# README
Thank you for taking the time to review my Ibotta Dev Project. I appreciate your consideration.

# Getting Started
### Clone the repository
Clone the repository:
```{bash}
git clone https://github.com/PlanetEfficacy/anagram.git
```

### Setup the database
The project is to build an API that allows fast searches for [anagrams](https://en.wikipedia.org/wiki/Anagram).

#### Create the database:
```{bash}
rake db:create
```
#### Execute database migration:
```{bash}
rake db:migrate
```
The schema for this migration is
```
create_table "words", force: :cascade do |t|
  t.string   "value"
  t.string   "alphabetize"
  t.datetime "created_at",  null: false
  t.datetime "updated_at",  null: false
end
```

#### Import seed data:
As per the project instructions:
`Ingesting the file doesn’t need to be fast, and you can store as much data in memory as you like.`
Running the seed file takes a while. The time comes from loading each word as well as its alphabetized form into the database. A word's alphabetized form is derived by:

  1. splitting the word by character
  2. sorting the characters alphabetically
  3. joining the split word back together

It is more performant to query the database for anagrams once we include both the word's value (text) and its alphabetized form in our word record since the heavy lifting part of the anagram algorithm is done up front upon running the db seed and upon the subsequent creation of words.
```{bash}
rake db:seed
```
#### Run the test suite:
This project has 100% test coverage according to the SimpleCov gem. I followed a strict TDD methodology when writing this code. My approach was to rigorously test at the unit level. I wrote request specs that checked for proper routing, but use mocks and stubs because I trust my unit tests and this makes the suite overall more performant. The exception to this approach is the `spec/requests/words_spec.rb` test, which creates database records. The entire suite of 40 examples runs on my machine consistently under 1.5 seconds. To run the test suite type:
```{bash}
rspec
```
A secondary test file, provided in the instructions for this project, can be run from the root of the project with the following command. The project must be running on localhost:3000 prior to running this command. Also, DO NOT run this test once you have seeded the database as one of the tests will check an endpoint that will delete the entire database.
**Caution, do not run this command without commenting out the delete all test once you have seeded your database**
```{bash}
ruby anagram_test.rb
```
#### Start the development server:
```{bash}
rails server
```
# Functionality
#### POST /words.json
Takes a JSON array of English-language words and adds them to the corpus (data store)

The following curl command will add words to the corpus
```{bash}
curl --request POST \
  --url http://localhost:3000/words.json \
  --header 'cache-control: no-cache' \
  --header 'content-type: application/json' \
  --data '{ "words": ["read", "dear", "dare"] }'
```
and return:
```json
[
    {
        "id": 236538,
        "value": "read",
        "alphabetize": "ader",
        "created_at": "2017-02-16T21:44:46.919Z",
        "updated_at": "2017-02-16T21:44:46.919Z"
    },
    {
        "id": 236539,
        "value": "dear",
        "alphabetize": "ader",
        "created_at": "2017-02-16T21:44:46.924Z",
        "updated_at": "2017-02-16T21:44:46.924Z"
    },
    {
        "id": 236540,
        "value": "dare",
        "alphabetize": "ader",
        "created_at": "2017-02-16T21:44:46.929Z",
        "updated_at": "2017-02-16T21:44:46.929Z"
    }
]
```
#### GET /anagrams/:word.json
Returns a JSON array of English-language words that are anagrams of the word passed in the URL.

The following curl command will get all of the anagrams of a given word:
```{bash}
curl --request GET \
  --url http://localhost:3000/anagrams/read.json \
  --header 'cache-control: no-cache'
```
and returns:
```json
{
  "anagrams": [
    "dear",
    "dare"
  ]
}
```
The endpoint supports an optional query param that indicates the maximum number of results to return. The following command will limit the query to 1 anagram.
```{bash}
curl --request GET \
  --url 'http://localhost:3000/anagrams/read.json?limit=1' \
  --header 'cache-control: no-cache'
```
The above request returns:
```json
{
  "anagrams": [
    "dear"
  ]
}
```
#### DELETE /words/:word.json
Deletes a single word from the data store.
```{bash}
curl -i -X DELETE http://localhost:3000/words/read.json
```
and returns:
```
HTTP/1.1 200 OK
```
#### DELETE /words.json
Deletes all contents of the data store.
```{bash}
curl -i -X DELETE http://localhost:3000/words.json
```
and returns:
```
HTTP/1.1 204 No Content
```
# Optional Functionality
In addition to the above base functionality the following features have also been implemented.
#### GET /word-count
Returns a count of words in the corpus and min/max/median/average word length.
```{bash}
curl --request GET --url 'http://localhost:3000/word-count'
```
and returns:
```json
{
  "count": 3,
  "min": 4,
  "max": 4,
  "median": 4.0,
  "average": 4.0
}
```
#### Optional proper noun scope
All of the following GET requests can be scoped to exclude proper nouns from the corpus.
```{bash}
curl --request GET --url 'http://localhost:3000/anagrams/:word.json?proper=false'
curl --request GET --url 'http://localhost:3000/word-count?proper=false'
curl --request GET --url 'http://localhost:3000/most-anagrams?proper=false'
curl --request GET --url 'http://localhost:3000/group-anagrams?proper=false'
```
#### GET /most-anagrams
Returns the words with the most anagrams.
```{bash}
curl --request GET --url 'http://localhost:3000/most-anagrams'
```
and returns:
```json
{
  "anagrams": ["read","dear","dare"]
}
```
#### GET /check-anagrams
Returns true if the provided word pair are anagrams of each other.
```{bash}
curl --request GET --url 'http://localhost:3000/check-anagrams?anagrams=read,dare'
```
and returns:
```json
{
  "words": ["read","dare"],
  "anagram": true
}
```
#### GET /group-anagrams
Returns all anagram groups of size >= x
```{bash}
curl --request GET --url 'http://localhost:3000/group-anagrams?size=2'
```
and returns:
```json
{
  "anagram_groups": [["read","dear","dare"]]
}
```
Note, the nested array in the above example connotes a set of anagram words. If the corpus contains multiple sets of anagram words, the above array would have an equivalent number of child elements.
#### DELETE /anagrams/:word.json
Deletes the given word as well as all of its anagrams.
```{bash}
curl --request DELETE --url 'http://localhost:3000/anagrams/read.json'
```
and returns:
```
HTTP/1.1 204 No Content
```

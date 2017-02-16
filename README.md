# README
Thank you for taking the time to review my Ibotta Dev Project. I appreciate your consideration.

# Getting Started
### Clone the repository
Clone the repository:
```{bash}
git clone https://github.com/PlanetEfficacy/anagram.git
```

### Setup the database
The project is to build an API that allows fast searches for [anagrams](https://en.wikipedia.org/wiki/Anagram). `dictionary.txt` is a text file containing every word in the English dictionary.

#### Create the database:
```{bash}
rake db:create
```
#### Execute database migration:
```{bash}
rake db:migrate
```
#### Import seed data:
As per the project instructions:
`Ingesting the file doesn’t need to be fast, and you can store as much data in memory as you like.`
Running the seed file takes a while. The time comes from loading each word as well as it's alphabetized form into the database. A word's alphabetized form is derived by:
1. splitting the word by character
2. sorting the characters alphabetically
3. joining the split word back together

It is more performant to query the database for anagrams once we include both the word's value (text) and its alphabetized form in our word record since the heavy lifting part of the anagram algorithm is done up front upon running the db seed.
```{bash}
rake db:seed
```
#### Run the test suite:
This project has 100% test coverage according to the SimpleCov gem. I followed a strict TDD methodology when writing this code. My approach was to rigorously test at the unit level. I wrote request specs that checked for proper routing, but use mocks and stubs because I trust my unit tests and this makes the suite overall more performant. The entire suite of 39 examples runs on my machine in roughly 1.5 seconds.
```{bash}
rspec
```
#### Start the development server:
```{bash}
rails server
```
# Functionality
**POST /words.json**

Takes a JSON array of English-language words and adds them to the corpus (data store)

```{bash}
# Adding words to the corpus
$ curl -i -X POST -d '{ "words": ["read", "dear", "dare"] }' http://localhost:3000/words.json
HTTP/1.1 201 Created
```

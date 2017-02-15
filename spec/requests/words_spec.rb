require "rails_helper"

RSpec.describe "Words API", type: :request do
  it 'posts an array of words' do
    post '/words', params: { words: ["read", "dear", "dare"] }

    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.length).to eq(3)
    expect(result.first['value']).to eq('read')
    expect(result.second['value']).to eq('dear')
    expect(result.third['value']).to eq('dare')
  end

  it "delets a word from words" do
    create :word, value: 'read'
    delete '/words/read.json'

    expect(response).to be_success
    expect(Word.count).to eq(0)
  end

  it "deletes all the words from words" do
    create :word, value: 'read'
    create :word, value: 'dear'
    delete '/words.json'

    expect(response).to be_success
    expect(Word.count).to eq(0)
  end
end

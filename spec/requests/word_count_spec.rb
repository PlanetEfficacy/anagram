require "rails_helper"

RSpec.describe "Word Count API", type: :request do
  it 'gets the word count of the corpus' do
    word_count = double()
    allow(WordCounter).to receive(:run).and_return(word_count)
    expect(WordCounter).to receive(:run)

    get '/word-count'

    result = JSON.parse(response.body)

    expect(response).to be_success
  end
end

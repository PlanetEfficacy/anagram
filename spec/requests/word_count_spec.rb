require 'rails_helper'

describe 'Word Count API', type: :request do
  let (:word_count) { double() }
  let (:word_counter) { double() }

  it 'gets the word count of the corpus' do
    allow(WordCounter).to receive(:new).with(exclude_proper_nouns: false).and_return(word_counter)
    allow(word_counter).to receive(:run).and_return(word_count)

    expect(WordCounter).to receive(:new).with(exclude_proper_nouns: false)
    expect(word_counter).to receive(:run)

    get '/word-count'

    expect(response).to be_success
  end

  it 'gets the word count of the corpus scoped to exclude proper nouns' do
    allow(WordCounter).to receive(:new).with(exclude_proper_nouns: true).and_return(word_counter)
    allow(word_counter).to receive(:run).and_return(word_count)

    expect(WordCounter).to receive(:new).with(exclude_proper_nouns: true)
    expect(word_counter).to receive(:run)

    get '/word-count?proper=false'

    expect(response).to be_success
  end
end

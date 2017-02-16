require 'rails_helper'

describe 'Most anagrams API', type: :request do
  it 'returns the words with the most anagrams' do
    expect(Word).to receive(:most_anagrams).with({exclude_proper_nouns: false})
    get '/most-anagrams'
    expect(response).to be_success
  end

  it 'returns the words with the most anagrams scoped to exclude proper nouns' do
    expect(Word).to receive(:most_anagrams).with({exclude_proper_nouns: true})
    get '/most-anagrams?proper=false'
    expect(response).to be_success
  end
end

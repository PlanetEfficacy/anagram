require 'rails_helper'

describe 'Check anagrams API', type: :request do
  let(:checker) { double }

  it 'returns true when two words are anagrams' do
    expect(AnagramChecker).to receive(:new).with('pants').and_return(checker)
    expect(checker).to receive(:check).with('antsp').and_return(true)

    get '/check-anagrams?anagrams=pants,antsp'
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['words']).to eq(['pants', 'antsp'])
    expect(result['anagram']).to eq(true)
  end

  it 'returns false when two words are not anagrams' do
    expect(AnagramChecker).to receive(:new).with('pants').and_return(checker)
    expect(checker).to receive(:check).with('dear').and_return(false)

    get '/check-anagrams?anagrams=pants,dear'
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result['words']).to eq(['pants', 'dear'])
    expect(result['anagram']).to eq(false)
  end
end

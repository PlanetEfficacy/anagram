require 'rails_helper'

describe 'Group anagrams API', type: :request do
  let(:grouper) { double }
  context 'scoped to include all words' do
    it 'returns anagram groups of size >= x' do
      expect(AnagramGrouper).to receive(:new).with(exclude_proper_nouns: false).and_return(grouper)
      expect(grouper).to receive(:get).with(2)

      get '/group-anagrams?size=2'

      expect(response).to be_success
    end
  end

  context 'scoped to include all words' do
    it 'returns anagram groups of size >= x' do
      expect(AnagramGrouper).to receive(:new).with(exclude_proper_nouns: true).and_return(grouper)
      expect(grouper).to receive(:get).with(2)

      get '/group-anagrams?size=2&proper=false'

      expect(response).to be_success
    end
  end
end

require 'rails_helper'

describe 'Anagrams API', type: :request do
  let(:word) { double }
  let(:anagram_finder) { double }

  context 'get to anagrams' do
    it 'get anagrams' do
      allow(Word).to receive(:find_or_create_by).with(value: 'read').and_return(word)
      allow(AnagramFinder).to receive(:new).with(word, exclude_proper_nouns: false).and_return(anagram_finder)
      expect(anagram_finder).to receive(:find)

      get '/anagrams/read.json'

      expect(response).to be_success
    end
  end

  context 'get to anagrams?limit=N' do
    it 'gets anagrams with given limit' do
      allow(Word).to receive(:find_or_create_by).with(value: 'read').and_return(word)
      allow(AnagramFinder).to receive(:new).with(word, exclude_proper_nouns: false).and_return(anagram_finder)
      expect(anagram_finder).to receive(:find).with(1)

      get '/anagrams/read.json?limit=1'

      expect(response).to be_success
    end
  end

  context 'get to anagrams?proper=false' do
    it 'gets anagrams excluding proper nouns' do
      allow(Word).to receive(:find_or_create_by).with(value: 'read').and_return(word)
      allow(AnagramFinder).to receive(:new).with(word, exclude_proper_nouns: true).and_return(anagram_finder)
      expect(anagram_finder).to receive(:find)

      get '/anagrams/read.json?proper=false'

      expect(response).to be_success
    end
  end

  describe 'delete to anagrams' do
    context 'unscoped' do
      it 'deletes the given word and all of its anagrams' do
        allow(Word).to receive(:find_or_create_by).with(value: 'read').and_return(word)
        allow(AnagramFinder).to receive(:new).with(word, exclude_proper_nouns: false).and_return(anagram_finder)
        expect(anagram_finder).to receive(:delete_all)

        delete '/anagrams/read.json'

        expect(response).to be_success
      end
    end

    context 'scoped' do
      it 'deletes the given word and all of its anagrams' do
        allow(Word).to receive(:find_or_create_by).with(value: 'read').and_return(word)
        allow(AnagramFinder).to receive(:new).with(word, exclude_proper_nouns: true).and_return(anagram_finder)
        expect(anagram_finder).to receive(:delete_all)

        delete '/anagrams/read.json?proper=false'

        expect(response).to be_success
      end
    end
  end
end

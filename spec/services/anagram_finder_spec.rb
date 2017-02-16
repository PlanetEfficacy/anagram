require 'rails_helper'

describe AnagramFinder do
  before(:each) do
    create :word, value: 'dear'
    create :word, value: 'Daer'
    create :word, value: 'dare'
    create :word, value: 'pant'
  end

  let(:read) { create :word, value: 'read' }
  let(:subject) { AnagramFinder.new(read)}
  let(:scoped_subject) {  AnagramFinder.new(read, exclude_proper_nouns: true) }

  describe AnagramFinder, '#find(N)' do
    context 'no arguments provided' do
      it 'returns all existing anagrams from the words table' do
        result = subject.find

        expect(result).to eq(['dear', 'Daer', 'dare'])
      end
    end

    context 'argument provided' do
      it 'returns N existing anagrams from the words table' do
        result = subject.find(1)

        expect(result).to eq(['dear'])
      end
    end

    context 'scoped to exclude proper nouns' do
      it 'returns all existing anagrams excluding proper nouns from the words table' do
        result = scoped_subject.find

        expect(result).to eq(['dear', 'dare'])
      end
    end

    context 'argument provided and scoped to exclude proper nouns' do
      it 'returns N existing anagrams from the words table' do
        result = scoped_subject.find(1)

        expect(result).to eq(['dear'])
      end
    end
  end

  describe AnagramFinder, '#delete_all(word)' do
    context 'include all words' do
      it 'deletes the given word and its anagrams' do
        result = subject.delete_all

        expect(Word.count).to eq(1)
      end
    end

    context 'exclude proper nouns' do
      it 'deletes the given word and its anagrams' do
        result = scoped_subject.delete_all

        expect(Word.count).to eq(2)
      end
    end
  end
end

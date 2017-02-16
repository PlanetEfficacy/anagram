require 'rails_helper'

describe Word, type: :model do
  describe Word, 'validations' do
    it { should validate_presence_of(:value) }

    it 'validates uniqueness of value' do
      Word.create(value: 'pants')
      Word.create(value: 'pants')
      expect(Word.count).to eq(1)
    end
  end

  describe Word, '#after save' do
    it 'triggers sort_value' do
      subject = Word.create(value: 'cba')

      result = subject.alphabetize

      expect(result).to eq('abc')
    end
  end

  describe Word, '#scope' do
    it 'can be scoped to exclude proper nounds' do
      create :word, value: 'pants'
      create :word, value: 'Pants'

      result = Word.exclude_proper_nouns

      expect(result.count).to eq(1)
      expect(result.first.value).to eq('pants')
    end
  end

  describe Word, '#group_anagrams' do
    it 'groups words into a hash by anagram count' do
      create :word, value: 'ab'
      create :word, value: 'ba'

      result = Word.group_anagrams

      expect(result).to eq({ 'ab' => 2 })
    end
  end

  describe Word, '#most_anagrams' do
    before(:each) do
      create :word, value: 'abcd'
      create :word, value: 'bcda'
      create :word, value: 'pants'
      create :word, value: 'Pants'
      create :word, value: 'Npats'
    end

    it 'returns an array of words that have the most anagrams' do
      expected = ['pants', 'Pants', 'Npats']
      result = Word.most_anagrams

      expect(result).to match(expected)
    end

    it 'returns an array of words that have the most anagrams scoped to exclude proper nounds' do
      expected = ['abcd', 'bcda']
      result = Word.most_anagrams(exclude_proper_nouns: true)

      expect(result).to match(expected)
    end

    it 'returns an array of words that have the most anagrams when there is a tie for top anagram count' do
      create :word, value: 'cdab'
      create :word, value: 'qwerty'
      expected = Word.where.not(value: 'qwerty').pluck(:value)

      result = Word.most_anagrams

      expect(result).to match(expected)
    end
  end
end

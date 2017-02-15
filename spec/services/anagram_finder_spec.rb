require 'rails_helper'

describe AnagramFinder do
  context "#find" do
    it "returns all existing anagrams in the words table" do
      create :word, value: 'dear'
      create :word, value: 'dare'
      create :word, value: 'pant'
      subject = AnagramFinder.new('read')

      result = subject.find

      expect(result).to eq(['dear', 'dare'])
    end
  end
end

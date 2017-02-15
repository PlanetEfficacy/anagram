require 'rails_helper'

describe AnagramFinder do
  context "#find" do
    it "returns all existing anagrams from the words table" do
      create :word, value: 'dear'
      create :word, value: 'dare'
      create :word, value: 'pant'
      subject = AnagramFinder.new('read')

      result = subject.find

      expect(result).to eq(['dear', 'dare'])
    end
  end

  context "#find(N)" do
    it "returns N existing anagrams from the words table" do
      create :word, value: 'dear'
      create :word, value: 'dare'
      create :word, value: 'pant'
      subject = AnagramFinder.new('read')

      result = subject.find(1)

      expect(result).to eq(['dear'])
    end
  end
end

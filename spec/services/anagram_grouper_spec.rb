require 'rails_helper'

describe AnagramGrouper do
  describe "#get" do
    before(:each) do
      create :word, value: 'ab'
      create :word, value: 'ba'
      create :word, value: 'abc'
      create :word, value: 'cba'
      create :word, value: 'Bca'
      create :word, value: 'pants'
    end

    context "scoped to include all words" do
      it "returns all anagram groups of size >= x" do
        subject = AnagramGrouper.new
        expected = [['abc', 'cba', 'Bca'], ['ab', 'ba']]

        result = subject.get(2)

        expect(result).to match(expected)
      end
    end

    context "scoped to exclude proper nouns" do
      it "returns all anagram groups of size >= x" do
        subject = AnagramGrouper.new(exclude_proper_nouns: true)
        expected = [['ab', 'ba'], ['abc', 'cba']]

        result = subject.get(2)

        expect(result).to match(expected)
      end
    end
  end
end

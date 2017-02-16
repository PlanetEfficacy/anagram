require 'rails_helper'

describe AnagramChecker do
  let(:read) { create :word, value: 'read' }
  let(:dear) { create :word, value: 'dear' }
  let(:dare) { create :word, value: 'Dare' }
  let(:pants) { create :word, value: 'pants' }
  let(:subject) { AnagramChecker.new(read) }

  context "#check" do
    it "returns true when anagrams are compared" do
      result_1 = subject.check(dear)
      result_2 = subject.check(dare)

      expect(result_1).to eq(true)
      expect(result_2).to eq(true)
    end

    it "returns false when non-anagrams are compared" do
      result_1 = subject.check(pants)
      result_2 = subject.check(read)

      expect(result_1).to eq(false)
      expect(result_2).to eq(false)
    end
  end
end

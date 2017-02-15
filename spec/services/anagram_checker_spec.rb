require 'rails_helper'

describe AnagramChecker do
  let(:subject) { AnagramChecker.new('read') }

  context "#check" do
    it "returns true when anagrams are compared" do
      result = subject.check('dear')

      expect(result).to eq(true)
    end

    it "returns false when non-anagrams are compared" do
      result_1 = subject.check('pants')
      result_2 = subject.check('abcd')
      result_3 = subject.check('read')

      expect(result_1).to eq(false)
      expect(result_2).to eq(false)
      expect(result_3).to eq(false)
    end
  end
end

require 'rails_helper'

describe MathNerd, "#average" do
  it "returns the average of a given array of numbers" do
    numbers = (1..10).to_a
    subject = MathNerd.new(numbers)

    result = subject.average

    expect(result).to eq(5.5)
  end
end

describe MathNerd, "#median" do
  context "even length array" do
    it "returns the median of a given array of numbers" do
      numbers = [3, 5, 12]
      subject = MathNerd.new(numbers)

      result = subject.median

      expect(result).to eq(5)
    end
  end

  context "even odd array" do
    it "returns the median of a given array of numbers" do
      numbers = [3, 13, 7, 5, 21, 23, 23, 40, 23, 14, 12, 56, 23, 29]
      subject = MathNerd.new(numbers)

      result = subject.median

      expect(result).to eq(22)
    end
  end
end

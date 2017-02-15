require 'rails_helper'

describe AnagramChecker do
  it "returns the anagrams of a given word" do
    subject = AnagramChecker.new('read')

    result_1 = subject.check('dear')
    result_2 = subject.check('pants')
    result_3 = subject.check('read')

    expect(result_1).to eq(true)
    expect(result_2).to eq(false)
    expect(result_3).to eq(false)
  end
end

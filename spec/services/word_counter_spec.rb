require 'rails_helper'

describe WordCounter, "#run" do
  it "returns a hash with min/max/median/average word lengths" do
    create :word, value: 'a'
    create :word, value: 'abc'
    create :word, value: 'abcdef'
    
    result = WordCounter.run

    expect(result[:min]).to eq(1)
    expect(result[:max]).to eq(6)
    expect(result[:median]).to eq(3.0)
    expect(result[:average]).to eq(3.3333333333333335)
  end
end

require 'rails_helper'

describe WordCounter, "#run" do
  before(:each) do
    create :word, value: 'a'
    create :word, value: 'abc'
    create :word, value: 'abcdef'
  end

  let (:subject) { WordCounter.new }
  let (:scoped_subject) { WordCounter.new(exclude_proper_nouns: true) }

  it "returns a hash with min/max/median/average word lengths" do
    result = subject.run

    expect(result[:min]).to eq(1)
    expect(result[:max]).to eq(6)
    expect(result[:median]).to eq(3.0)
    expect(result[:average]).to eq(3.3333333333333335)
  end

  it "returns a hash with min/max/median/average word lengths scoped to exclude proper nouns" do
    create :word, value: 'Abcdefghijklmnop'

    result = scoped_subject.run

    expect(result[:min]).to eq(1)
    expect(result[:max]).to eq(6)
    expect(result[:median]).to eq(3.0)
    expect(result[:average]).to eq(3.3333333333333335)
  end
end

require 'rails_helper'

RSpec.describe Word, type: :model do
  context "validations" do
    it { should validate_presence_of(:value) }
    it { should validate_uniqueness_of(:value) }
  end

  context "scope" do
    it "can be scoped to exclude proper nounds" do
      create :word, value: 'pants'
      create :word, value: 'Pants'

      result = Word.exclude_proper_nouns

      expect(result.count).to eq(1)
      expect(result.first.value).to eq('pants')
    end
  end
end

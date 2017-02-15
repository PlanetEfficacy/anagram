class Word < ApplicationRecord
  validates_presence_of :value
  validates_uniqueness_of :value

  def self.exclude_proper_nouns
    where("ASCII(left(value, 1)) between ASCII('a') and ASCII('z')")
  end
end

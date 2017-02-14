class Word < ApplicationRecord
  validates_presence_of :value
  validates_uniqueness_of :value
end

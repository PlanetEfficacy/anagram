class Word < ApplicationRecord
  validates_presence_of :value
  validates_uniqueness_of :value

  after_create :sort_value!

  def self.exclude_proper_nouns
    where("ASCII(left(value, 1)) between ASCII('a') and ASCII('z')")
  end

  def self.most_anagrams(scope={})
    where(alphabetize: scope_handler(scope)).pluck(:value)
  end

  private

  def sort_value!
    self.alphabetize = self.value.downcase.split('').sort.join
    self.save!
  end

  def self.anagram_count
    group(:alphabetize).order('count_id desc').count('id')
  end

  def self.anagram_count_scoped
    exclude_proper_nouns.anagram_count
  end

  def self.scope_handler(scope)
    scope[:exclude_proper_nouns] ? scoped_anagrams : unscoped_anagrams
  end

  def self.scoped_anagrams
    top_anagrams(anagram_count_scoped)
  end

  def self.unscoped_anagrams
    top_anagrams(anagram_count)
  end

  def self.top_anagrams(anagram_group)
    anagram_group.group_by { |k,v| v }.first.flatten.select { |elem| elem.class == String }
  end
end

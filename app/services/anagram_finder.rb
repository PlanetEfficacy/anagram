class AnagramFinder
  attr_reader :alphabetize, :value, :scope
  def initialize(word, scope={})
    @alphabetize = word.alphabetize
    @value = word.value
    @scope = scope
  end

  def find(n=Word.count)
    word.where("alphabetize=? AND NOT value=?", alphabetize, value).limit(n).pluck(:value)
  end

  private

  def word
    scope[:exclude_proper_nouns] ? Word.exclude_proper_nouns : Word
  end
end

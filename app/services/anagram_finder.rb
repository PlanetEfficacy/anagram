class AnagramFinder
  attr_reader :checker, :scope
  def initialize(word, scope={})
    @checker = AnagramChecker.new(word)
    @scope = scope
  end

  def find(n=Word.count)
    word.pluck(:value).select { |value| checker.check(value) }.first(n)
  end

  private

  def word
    scope[:exclude_proper_nouns] ? Word.exclude_proper_nouns : Word
  end
end

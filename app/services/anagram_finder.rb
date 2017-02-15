class AnagramFinder
  attr_reader :checker
  def initialize(word)
    @checker = AnagramChecker.new(word)
  end

  def find(n=Word.count)
    Word.pluck(:value).select { |value| checker.check(value) }.first(n)
  end
end

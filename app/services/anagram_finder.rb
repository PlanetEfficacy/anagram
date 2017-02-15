class AnagramFinder
  attr_reader :checker
  def initialize(word)
    @checker = AnagramChecker.new(word)
  end

  def find
    Word.pluck(:value).select { |value| checker.check(value) }
  end
end

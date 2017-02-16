class AnagramChecker
  attr_reader :word, :comparison

  def initialize(word)
    @word = word
  end

  def check(comparison)
    @comparison = comparison
    is_anagram?
  end

  private

    def same_letters?
      word.alphabetize == comparison.alphabetize
    end

    def different_words?
      word != comparison
    end

    def is_anagram?
      same_letters? && different_words?
    end

end

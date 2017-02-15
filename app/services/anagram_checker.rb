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

    def same_length?
      word.length == comparison.length
    end

    def same_letters?
      word_letters == comparison_letters
    end

    def word_letters
      word.downcase.split('').sort
    end

    def comparison_letters
      comparison.downcase.split('').sort
    end

    def different_words?
      word != comparison
    end

    def is_anagram?
      same_length? && same_letters? && different_words?
    end

end

class WordCounter
  attr_reader :scope
  def initialize(scope={})
    @scope = scope
  end

  def run
    {
      count:    count,
      min:      min,
      max:      max,
      median:   median,
      average:  average
    }
  end

  private

  def count
    word.count
  end

  def min
    word.pluck("min(length(value))").first
  end

  def max
    word.pluck("max(length(value))").first
  end

  def median
    nerd.median
  end

  def average
    nerd.average
  end

  def word_lengths
    word.pluck("length(value)")
  end

  def nerd
    MathNerd.new(word_lengths)
  end

  def word
    scope[:exclude_proper_nouns] ? Word.exclude_proper_nouns : Word
  end
end

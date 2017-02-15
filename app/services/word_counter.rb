class WordCounter
  def self.run
    {
      min:      min,
      max:      max,
      median:   median,
      average:  average
    }
  end

  private

  def self.min
    Word.pluck("min(length(value))").first
  end

  def self.max
    Word.pluck("max(length(value))").first
  end

  def self.median
    nerd.median
  end

  def self.average
    nerd.average
  end

  def self.word_lengths
    Word.pluck("length(value)")
  end

  def self.nerd
    MathNerd.new(word_lengths)
  end
end

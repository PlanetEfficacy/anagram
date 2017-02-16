class AnagramGrouper
  attr_reader :word, :size
  def initialize(scope={})
    @word = scope[:exclude_proper_nouns] ? Word.exclude_proper_nouns : Word
  end

  def get(size)
    @size = size
    get_words_with_min_group_size
  end

  private

  def groups_min_size
    word.group_anagrams.select { |alphabetize, count| count >= size }
  end

  def get_words_with_min_group_size
    groups_min_size.map { |alphabetize, count| get_anagrams(alphabetize) }
  end

  def get_anagrams(alphabetize)
    word.where(alphabetize: alphabetize).pluck(:value)
  end
end

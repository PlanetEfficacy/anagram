class AnagramGrouper
  attr_reader :word, :size
  def initialize(scope={})
    @word = scope[:exclude_proper_nouns] ? Word.exclude_proper_nouns : Word
  end

  def get(size)
    @size = size
    get_words_with_min_size
  end

  private

  def groups_min_size
    word.group(:alphabetize).order('count_id desc').count('id').select { |k,v| v >= size }
  end

  def get_words_with_min_size
    groups_min_size.map { |alpha, count| word.where(alphabetize: alpha).pluck(:value) }
  end
end

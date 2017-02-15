class WordCountController < ApplicationController
  def index
    @word_count = word_counter.run
    render json: @word_count, status: :ok
  end

  private

  def word_counter
    WordCounter.new(exclude_proper_nouns: scoped?)
  end
end

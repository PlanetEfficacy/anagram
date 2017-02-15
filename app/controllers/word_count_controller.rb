class WordCountController < ApplicationController
  def index
    @word_count = WordCounter.run
    render json: @word_count, status: :ok
  end
end

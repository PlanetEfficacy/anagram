class WordsController < ApplicationController
  def create
    @words = Word.create(words)
    render json: @words
  end

  private

  def words
    params[:words].map { |word| { value: word } }
  end
end

class WordsController < ApplicationController
  def create
    @words = Word.create(words)
    render json: @words
  end

  def destroy
    Word.find_by(value: params[:id]).destroy
    render status: :accepted
  end

  private

  def words
    params[:words].map { |word| { value: word } }
  end
end

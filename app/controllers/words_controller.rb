class WordsController < ApplicationController
  def create
    @words = Word.create(words)
    render json: @words, status: :created
  end

  def destroy
    Word.find_by(value: params[:id]).destroy
    render status: :ok
  end

  def destroy_all
    Word.destroy_all
    render status: :no_content
  end

  private

  def words
    params[:words].map { |word| { value: word } }
  end
end

class CheckAnagramsController < ApplicationController
  def index
    render json: { words: words, anagram: is_anagram? }, status: :ok
  end

  private

  def words
    params[:anagrams].split(',')
  end

  def is_anagram?
    AnagramChecker.new(words.first).check(words.second)
  end
end

class AnagramsController < ApplicationController
  def show
    @anagrams = { anagrams: anagrams }
    render json: @anagrams, status: :ok
  end

  def destroy
    anagram_finder.delete_all
    render status: :no_content
  end

  private

  def limit
    params[:limit] ? params[:limit].to_i : nil
  end

  def anagrams
    limit.nil? ? anagram_finder.find : anagram_finder.find(limit)
  end

  def anagram_finder
    AnagramFinder.new(word, exclude_proper_nouns: scoped?)
  end

  def word
    Word.find_or_create_by(value: params[:id])
  end
end

class AnagramsController < ApplicationController
  def show
    @anagrams = { anagrams: anagrams }
    render json: @anagrams
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
    AnagramFinder.new(params[:id], exclude_proper_nouns: scoped?)
  end
end

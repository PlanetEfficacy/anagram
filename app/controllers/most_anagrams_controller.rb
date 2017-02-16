class MostAnagramsController < ApplicationController
  def index
    @anagrams = Word.most_anagrams(exclude_proper_nouns: scoped?)
    render json: { anagrams: @anagrams }, status: :ok
  end
end

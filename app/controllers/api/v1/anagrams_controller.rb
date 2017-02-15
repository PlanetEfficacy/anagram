class Api::V1::AnagramsController < ApplicationController
  def show
    @anagrams = { anagrams: AnagramFinder.new(params[:id]).find }
    render json: @anagrams
  end
end

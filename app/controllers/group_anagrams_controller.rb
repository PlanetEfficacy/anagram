class GroupAnagramsController < ApplicationController
  def index
    render json: { anagram_groups: anagram_groups }, status: :ok
  end

  private

  def anagram_groups
    AnagramGrouper.new(exclude_proper_nouns: scoped?).get(params[:size].to_i)
  end
end

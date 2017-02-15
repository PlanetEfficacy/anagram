class ApplicationController < ActionController::API
  protected
  def scoped?
    params[:proper] == 'false'
  end
end

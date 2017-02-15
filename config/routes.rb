Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :anagrams, only: :show
  resources :words, only: [:create, :destroy] do
    delete :index, on: :collection, action: :destroy_all
  end

end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :words, only: [:create]
  resources :anagrams, only: [:show]

end

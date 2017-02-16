Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :anagrams, only: :show
  resources :words, only: [:create, :destroy] do
    delete :index, on: :collection, action: :destroy_all
  end

  get 'word-count', to: 'word_count#index', as: :word_count
  get 'most-anagrams', to: 'most_anagrams#index', as: :most_anagrams
  get 'check-anagrams', to: 'check_anagrams#index', as: :check_anagrams

end

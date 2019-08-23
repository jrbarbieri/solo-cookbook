Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'recipes#index'

  resources :recipes, only: %i[index show new create update edit] do
    collection do
      get 'search'
    end
  end
  resources :recipe_types, only: %i[show new create]
end

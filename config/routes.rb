Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'filter', to: 'home#filter'
  resources :properties, only: [:show, :new, :create, :edit, :update]
  resources :property_types, only: [:new, :create]
  resources :property_locations, only: [:new, :create]
end

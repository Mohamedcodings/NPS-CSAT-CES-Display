Rails.application.routes.draw do
  root 'surveys#index'
  resources :surveys, only: [:index, :new, :create]
end

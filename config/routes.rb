Rails.application.routes.draw do
  resources :reservations, only: %i[index create update]
  resources :restaurants, only: %i[index create]
  resources :tables, only: %i[index create]
end

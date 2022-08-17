Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  resources :users, only: :show
  resources :prototypes, only: [:create, :new, :edit, :update, :destroy, :show] do
    resources :comments, only: :create
  end
  
end

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: "items#index"
  resources :users, only: [:new, :create]
  resources :items do
    resources :item_transactions, only:[:index, :create]
    resources :comments, only: :create
  end
end

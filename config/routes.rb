Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :users, only: [:new, :create]
  resources :items do
    resources :item_transactions, only:[:index, :create]
  end
end

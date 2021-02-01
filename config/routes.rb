Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: "items#index"
  resources :users, only: [:new, :create, :edit, :update, :show]

  resources :items do
    resources :item_transactions, only:[:index, :create]
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy, :show]
    member do
      get 'search'
    end
  end

  resources :comments, only: [:create, :destroy] do
    resources :comment_childrens, only: [:create, :destroy]
  end
end

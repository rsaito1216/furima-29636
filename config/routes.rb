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
    collection do
      get 'get_category_children', defaults: { fomat: 'json'}
      get 'get_category_grandchildren', defaults: { fomat: 'json'}
    end
    member do
      get 'search'
    end
  end

  resources :categories, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end

  

end

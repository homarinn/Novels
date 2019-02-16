Rails.application.routes.draw do
  root to: "toppages#index"
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'rankings/novel', to: 'rankings#novel'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create] do
    member do
      get :likes
    end
  end
  
  resources :novels, only: [:index, :show, :new, :create, :edit, :update, :destroy] 
  resources :bookmarks, only: [:create, :destroy]
  resources :stories, only: [:show, :new, :create, :edit, :update, :destroy]
end

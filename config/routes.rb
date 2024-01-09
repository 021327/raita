Rails.application.routes.draw do
  root to: 'toppages#index'

  # ログイン関連のルーティング
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # サインアップ関連のルーティング
  get 'signup', to: 'users#new'

  resources :users, except: [:edit, :show, :update, :destroy] do
    member do
      get :participants
    end
  end

  resources :events, only: [:show, :new, :create, :edit, :update, :destroy] do
    member do
      post 'participant', to: 'participants#create'
      delete 'unparticipant', to: 'participants#destroy'
    end
  end
  
  resources :participants, only: [:index]
end

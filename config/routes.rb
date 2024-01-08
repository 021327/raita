Rails.application.routes.draw do
  root to: 'toppages#index'

  # ログイン関連のルーティング
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # サインアップ関連のルーティング
  get 'signup', to: 'users#new'

  resources :users do
    member do
      get :participants
    end
  end

  resources :events, only: [:show, :new, :create, :edit, :update, :destroy] do
    member do
      delete 'unparticipant', to: 'participants#destroy'
      get 'participants', to: 'events#participants'
    end
  end
  
  resources :participants, only: [:index]
end

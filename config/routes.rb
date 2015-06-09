Rails.application.routes.draw do
  scope defaults: {format: :json} do
    resources :games, only: [:index, :show]
    resources :users, only: [:create, :update] do
      post :login, on: :collection
      resources :game_ownerships, only: [:index, :create, :update, :destroy]
      resources :friendships, only: [:index, :destroy]
    end
    resources :friendship_invites, only: [:index, :create, :destroy] do
      post :accept, on: :member
    end
    resources :teams, only: [:index, :show, :create]
    resources :team_memberships, only: [:index, :create, :update, :destroy]
  end
end

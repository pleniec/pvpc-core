Rails.application.routes.draw do
  scope defaults: {format: :json} do
    resources :users, only: [:index, :show, :create, :update] do
      post :login, on: :collection
    end
    resources :games, only: [:index, :show]
    resources :game_ownerships, only: [:index, :create, :update, :destroy]
    resources :friendships, only: [:index, :destroy]
    resources :friendship_invites, only: [:index, :create, :destroy] do
      post :accept, on: :member
    end
    resources :teams, only: [:index, :show, :create, :update]
    resources :team_memberships, only: [:index, :update, :destroy]
    resources :conversation_participants, only: [:index]
    resources :conversations, only: [:create, :show]
    resources :messages, only: [:index]
    resources :notifications, only: [:index, :update]
    resources :comments, only: [:index, :create, :update, :destroy]
    resources :team_membership_propositions, only: [:index, :create, :destroy] do
      post :accept, on: :member
    end
  end
end

Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope defaults: {format: :json} do
    namespace :public do
      resources :users, only: [:index, :show, :create, :update] do
        post :login, on: :collection
      end
      resources :games, only: [:index, :show]
      resources :game_ownerships, only: [:index, :create, :update, :destroy]
      resources :friendships, only: [:index, :destroy]
      resources :friendship_invites, only: [:index, :create, :destroy] do
        post :accept, on: :member
      end
      resources :teams, only: [:index, :show, :create]
      resources :team_memberships, only: [:index, :create, :update, :destroy]
      resources :divisions, only: [:index, :show, :create, :update, :destroy]
      resources :conversation_participants, only: [:index]
      resources :conversations, only: [:create, :show]
    end
    namespace :private do
    end
  end
end

Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, constraints: {format: :json}, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: [:create, :update] do
        post :login, on: :collection
        resources :games, only: [:index, :create, :update, :destroy],
                  controller: :user_games
        resources :friendship_invites, only: [:index, :create, :update, :destroy]
        resources :friendships, only: [:index, :destroy]
        resources :teams, only: [:index, :create],
                  controller: :user_teams
      end
      resources :teams, only: :show
      resources :games, only: [:index]
    end
  end
end

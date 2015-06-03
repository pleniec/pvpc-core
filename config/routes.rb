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
      end
      resources :teams, only: [:index, :show, :create] do
        resources :divisions, only: [:index, :show, :create]
        resources :members, only: [:index, :create, :update, :destroy],
                  controller: :team_members
      end
      resources :games, only: [:index, :show]
    end
  end
end

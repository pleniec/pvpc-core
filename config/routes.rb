Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, constraints: {format: :json}, defaults: {format: :json} do
    namespace :public do
      resources :users, only: [:index, :create, :update] do
        post :login, on: :collection
        resources :games, only: [:index, :create, :update, :destroy],
                  controller: :user_games
        resources :friendship_invites, only: [:index, :create, :update, :destroy]
        resources :friendships, only: [:index, :destroy]
      end
      resources :games, only: [:index]
    end
  end
end

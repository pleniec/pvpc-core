Rails.application.routes.draw do
  devise_for :users, skip: :all
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, constraints: {format: :json}, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: [:create, :update] do
        post :login, on: :collection
        resources :games, only: [:index, :create, :update, :destroy],
                  controller: :user_games
      end
      resources :friendship_invites, path: 'user/invites',
                only: [:index, :create]
      resources :games, only: [:index]
    end
  end
end

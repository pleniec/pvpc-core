Rails.application.routes.draw do
  devise_for :users, skip: :all
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, constraints: {format: :json}, defaults: {format: :json} do
    namespace :v1 do
      resources :user, only: [:create, :update] do
        post :login, on: :collection
      end
      resources :user_games, path: 'user/games',
                only: [:index, :create, :update, :destroy]
      resources :friendship_invites, path: 'user/invites',
                only: [:index, :create]
      resources :games, only: [:index, :show]
    end
  end
end

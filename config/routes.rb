Rails.application.routes.draw do
  devise_for :users, skip: :all
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, constraints: {format: :json}, defaults: {format: :json} do
    namespace :v1 do
      resources :user, only: [:create] do
        collection do
          post :login
        end
      end
      resources :user_games, path: 'user/games',
                only: [:index, :create, :update, :destroy]
      resources :games, only: [:index, :show]
    end
  end
end

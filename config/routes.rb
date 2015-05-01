Rails.application.routes.draw do
  devise_for :users, skip: :all
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, constraints: {format: :json}, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: [:create] do
        post :login, on: :collection
      end
      resources :games, only: [:index, :show]
    end
  end
end

module Users
  class Ability
    include CanCan::Ability

    def initialize(current_user)
      current_user ||= Users::User.new

      can [:index, :show, :create, :login], Users::User

      can :update, Users::User do |user|
        user == current_user
      end

      can :index, Games::Game

      can :index, Games::UserGame

      can [:update, :destroy, :create], Games::UserGame do |user_game|
        user_game.user == current_user
      end

      can [:index, :update, :destroy], Users::FriendshipInvite, to_user_id: current_user.id

      can :create, Users::FriendshipInvite, from_user_id: current_user.id

      can :index, Users::Friendship

      can :destroy, Users::Friendship do |friendship|
        friendship.user == current_user
      end
    end
  end
end

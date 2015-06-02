module Users
  class Ability
    include CanCan::Ability

    def initialize(current_user)
      current_user ||= Users::User.new

      can :update, Users::User do |user|
        user == current_user
      end

      can [:update, :destroy, :create], Games::UserGame do |user_game|
        user_game.user == current_user
      end

      can [:index, :update, :destroy], Users::FriendshipInvite do |friendship_invite|
        friendship_invite.to == current_user
      end

      can :create, Users::FriendshipInvite do |friendship_invite|
        friendship_invite.from == current_user
      end

      can :destroy, Users::Friendship do |friendship|
        friendship.user == current_user
      end
    end
  end
end

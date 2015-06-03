class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new

    can :update, User do |user|
      user == current_user
    end

    can [:update, :destroy, :create], UserGame do |user_game|
      user_game.user == current_user
    end

    can [:index, :update, :destroy], FriendshipInvite do |friendship_invite|
      friendship_invite.to == current_user
    end

    can :create, FriendshipInvite do |friendship_invite|
      friendship_invite.from == current_user
    end

    can :destroy, Friendship do |friendship|
      friendship.user == current_user
    end

    can :create, Team do |team|
      team.founder_id == current_user.id
    end
  end
end

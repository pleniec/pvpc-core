class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new

    can [:index, :show, :create, :login], User
    can :update, User, id: current_user.id
    can :index, Game
    can :index, UserGame
    can [:update, :destroy, :create], UserGame do |user_game|
      user_game.user == current_user
    end
    can [:index, :update, :destroy], FriendshipInvite, to_user_id: current_user.id
    can :create, FriendshipInvite, from_user_id: current_user.id
    can :index, Friendship
    can :destroy, Friendship, user_id: current_user.id
  end
end

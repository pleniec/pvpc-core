class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:index, :create, :login], User
    can :update, User, id: user.id
    can :index, Game
    can [:index, :create], UserGame
    can [:update, :destroy], UserGame, user_id: user.id
    can [:index, :update, :destroy], FriendshipInvite, to_user_id: user.id
    can [:create], FriendshipInvite, from_user_id: user.id
  end
end

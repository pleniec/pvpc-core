class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Game
    can [:index, :create], UserGame
    can [:update, :destroy], UserGame, user_id: user.id
  end
end

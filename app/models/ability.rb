class Ability
  include CanCan::Ability

  def initialize(current_user, params)
    current_user ||= User.new

    can [:index, :show], Game
    can [:create, :login], User
    can :update, User do |user|
      user == current_user
    end
    can :index, GameOwnership
    can [:create, :update, :destroy], GameOwnership do |game_ownership|
      game_ownership.user == current_user
    end
=begin
    ### USERS

    can :show, User
    can :update, User do |user|
      user == current_user
    end

    ### GAMES

    can [:index, :show], Game
    can :index, UserGame
    can [:create, :update, :destroy], UserGame do |user_game|
      user_game.user == current_user
    end

    ### FRIENDSHIPS
   
    can :index, FriendshipInvite do
      params[:user_id] == current_user.id
    end

    can [:index, :update, :destroy], FriendshipInvite do |friendship_invite|
      friendship_invite.to == current_user
    end

    ###

    can :create, FriendshipInvite do |friendship_invite|
      friendship_invite.from == current_user
    end

    can :destroy, Friendship do |friendship|
      friendship.user == current_user
    end

    can :create, Team do |team|
      team.founder_id == current_user.id
    end

    can [:create, :update, :destroy], TeamMembership do |team_membership|
      team_membership.team.founder == current_user
    end
=end
  end
end

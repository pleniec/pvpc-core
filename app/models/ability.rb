class Ability
  include CanCan::Ability

  def initialize(current_user, params)
    current_user ||= User.new

    can [:index, :show], Game

    ###

    can :index, GameOwnership
    can [:create, :update, :destroy], GameOwnership do |game_ownership|
      game_ownership.user == current_user
    end

    ###

    can [:create, :login], User
    can :update, User do |user|
      user == current_user
    end

    ###

    can [:create], FriendshipInvite do |friendship_invite|
      friendship_invite.from_user == current_user
    end
    if params[:to_user_id] == current_user.id
      can :index, FriendshipInvite
    end
    can [:destroy, :accept], FriendshipInvite do |friendship_invite|
      friendship_invite.to_user == current_user
    end

    ###

    can :index, Friendship
    can :destroy, Friendship do |friendship|
      friendship.user == current_user
    end

    ###

    can [:index, :show], Team
    can :create, Team do |team|
      team.founder == current_user
    end

    ###

    can :index, TeamMembership
    can [:create, :update, :destroy], TeamMembership do |team_membership|
      team_membership.team.founder == current_user
    end
  end
end

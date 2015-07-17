class Ability
  include CanCan::Ability

  def initialize(current_user, params)
    current_user ||= User.new

    ###

    can [:index, :show], Game

    ###

    can :index, GameOwnership
    can [:create, :update, :destroy], GameOwnership do |game_ownership|
      game_ownership.user == current_user
    end

    ###

    can [:index, :create, :login, :show], User
    can [:update, :strangers], User do |user|
      user == current_user
    end

    ###

    can [:create], FriendshipInvite do |friendship_invite|
      friendship_invite.from_user == current_user
    end
    can :index, FriendshipInvite if params[:to_user_id].to_i == current_user.id
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

    ###

    can [:index, :show], Division
    can [:create, :update, :destroy], Division do |division|
      division.team.founder == current_user
    end

    ###

    can [:create, :show], Conversation do |conversation|
      conversation.conversation_participants.any? { |cp| cp.user_id == current_user.id }
    end

    ###

    can :index, ConversationParticipant if params[:user_id].to_i == current_user.id
  end
end

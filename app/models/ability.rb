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
    can :index, FriendshipInvite if params[:to_user_id].try(:to_i) == current_user.id
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
    can [:create, :update], Team do |team|
      team.founder == current_user
    end

    ###

    can :index, TeamMembership
    can [:update, :destroy], TeamMembership do |team_membership|
      team_membership.try(:team).try(:founder) == current_user
    end

    ###

    can [:create, :show], Conversation do |conversation|
      conversation.conversation_participants.any? { |cp| cp.user_id == current_user.id }
    end

    ###

    can :index, ConversationParticipant if params[:user_id].try(:to_i) == current_user.id

    ###

    can :index, Notification if params[:user_id].try(:to_i) == current_user.id
    can(:check, Notification) { |n| n.user == current_user }

    ###

    can :index, Comment
    can([:create, :update, :destroy], Comment) { |c| c.user == current_user }

    ###

    can(:index, TeamMembershipProposition) if params[:user_id] == current_user.id
    can(:index, TeamMembershipProposition) if Team.find_by_id(params[:team_id]).try(:founder) == current_user
    can :create, TeamMembershipProposition do |team_membership_proposition|
      team_membership_proposition.user == current_user && team_membership_proposition.type == 'REQUEST' ||
      team_membership_proposition.team.try(:founder) == current_user && team_membership_proposition.type == 'INVITE'
    end
    can [:accept, :destroy], TeamMembershipProposition do |team_membership_proposition|
      team_membership_proposition.type == 'REQUEST' && team_membership_proposition.team.founder == current_user ||
      team_membership_proposition.type == 'INVITE' && team_membership_proposition.user == current_user
    end
  end
end

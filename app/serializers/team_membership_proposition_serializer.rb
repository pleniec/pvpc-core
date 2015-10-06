class TeamMembershipPropositionSerializer < ModelSerializer
  attributes :id, :type
  has_one :user, serializer: UserSerializer
  has_one :team, serializer: TeamSerializer
end

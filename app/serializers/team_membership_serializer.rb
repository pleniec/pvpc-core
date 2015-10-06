class TeamMembershipSerializer < ModelSerializer
  attributes :id
  has_one :user, serializer: UserSerializer
  has_one :team, serializer: TeamSerializer
end

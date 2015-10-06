class DetailedTeamSerializer < TeamSerializer
  attributes :description
  has_one :founder, serializer: UserSerializer
end

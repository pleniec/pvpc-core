class DetailedTeamSerializer < TeamSerializer
  attributes :tag, :description
  has_one :founder, serializer: UserSerializer
end

class DetailedUserSerializer < UserSerializer
  attributes :sex, :nationality, :description
  has_many :game_ownerships, serializer: GameOwnershipSerializer
end

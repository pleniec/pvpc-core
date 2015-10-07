class GameOwnershipSerializer < ModelSerializer
  attributes :id, :nickname
  has_one :game, serializer: GameSerializer
end

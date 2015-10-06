class GameOwnershipSerializer < ActiveModel::Serializer
  attributes :id
  has_one :game, serializer: GameSerializer
end

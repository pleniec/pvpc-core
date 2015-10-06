class GameOwnershipSerializer < ActiveModel::Serializer
  attributes :id, :nickname
  has_one :game, serializer: GameSerializer
end

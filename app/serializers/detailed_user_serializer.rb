class DetailedUserSerializer < UserSerializer
  attributes :sex, :nationality, :description
  has_many :game_ownerships, serializer: GameOwnershipSerializer

  def attributes
    hash = super
    hash[:access_token] = object.session.access_token if object.session.access_token
    hash
  end
end

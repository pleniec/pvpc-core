class FriendshipSerializer < ModelSerializer
  attributes :id
  has_one :friend, serializer: UserSerializer
end

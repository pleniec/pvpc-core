class FriendshipInviteSerializer < ModelSerializer
  attributes :id
  has_one :from_user, serializer: UserSerializer
  has_one :to_user, serializer: UserSerializer
end

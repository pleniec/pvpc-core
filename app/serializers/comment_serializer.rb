class CommentSerializer < ModelSerializer
  attributes :id, :text, :created_at, :updated_at
  has_one :user, serializer: UserSerializer
end

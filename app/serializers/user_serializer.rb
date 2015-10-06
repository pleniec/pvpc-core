class UserSerializer < ModelSerializer
  attributes :id, :email, :nickname, :image_url
end

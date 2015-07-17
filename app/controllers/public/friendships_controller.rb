module Public
  class FriendshipsController < APIController
    has_scope :user_id
  end
end

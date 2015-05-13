class FriendshipInvite < ActiveRecord::Base
  belongs_to :from, class_name: 'User', foreign_key: :from_user_id
  belongs_to :to, class_name: 'User', foreign_key: :to_user_id
end

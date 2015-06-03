module Users
  class Friendship < ActiveRecord::Base
    belongs_to :user
    belongs_to :friend, class_name: 'User', foreign_key: :friend_id

    validates :user, presence: true
    validates :friend, presence: true, uniqueness: {scope: :user}

    def end!
      transaction do
        reverse.destroy!
        destroy!
      end
    end

    def reverse
      Friendship.find_by!(user: friend, friend: user)
    end

    def to_hash
      {id: id, friend: friend.to_hash_without_access_token}
    end
  end
end

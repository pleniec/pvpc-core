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

    def to_builder
      Jbuilder.new do |json|
        json.id id
        json.friend { json.merge! friend.to_builder.attributes! }
      end
    end
  end
end
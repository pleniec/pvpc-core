module Users
  class FriendshipInvite < ActiveRecord::Base
    belongs_to :from, class_name: 'Users::User', foreign_key: :from_user_id
    belongs_to :to, class_name: 'Users::User', foreign_key: :to_user_id

    default_scope { eager_load(:from, :to) }

    validates :from, presence: true
    validates :to, presence: true, uniqueness: {scope: :from}
    validate :user_cannot_invite_himself
    validate :user_cannot_invite_friends

    def accept!
      Users::Friendship.create!(user: from, friend: to)
      Users::Friendship.create!(user: to, friend: from)
      destroy!
    end

    def to_builder
      Jbuilder.new do |json|
        json.id id
        json.from { json.merge! from.to_builder.attributes! }
      end
    end

    private

    def user_cannot_invite_himself
      if from == to
        errors[:to] << 'cannot invite yourself'
      end
    end

    def user_cannot_invite_friends
      if from.friends.exists?(to.id)
        errors[:to] << 'cannot invite friend'
      end
    end
  end
end

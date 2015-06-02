module Users
  class FriendshipInvite < ActiveRecord::Base
    belongs_to :from, class_name: 'Users::User', foreign_key: :from_user_id
    belongs_to :to, class_name: 'Users::User', foreign_key: :to_user_id

    default_scope { eager_load(:from, :to) }

    validates :from, presence: true
    validates :to, presence: true
    validate :cannot_invite_himself
    validate :cannot_invite_friends
    validate :cannot_invite_already_invited_user
    validate :cannot_invite_user_that_invited_you

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

    def cannot_invite_himself
      if from == to
        errors[:to] << 'cannot invite yourself'
      end
    end

    def cannot_invite_friends
      if from.friends.exists?(to.id)
        errors[:to] << 'cannot invite friend'
      end
    end

    def cannot_invite_already_invited_user
      if Users::FriendshipInvite.exists?(from: from, to: to)
        errors[:to] << 'user is already invited'
      end
    end

    def cannot_invite_user_that_invited_you
      if Users::FriendshipInvite.exists?(from: to, to: from)
        errors[:to] << 'cannot invite user that invited you'
      end
    end
  end
end

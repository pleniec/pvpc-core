class FriendshipInvite < ActiveRecord::Base
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  validates :from_user, presence: true
  validates :to_user, presence: true
  validate :cannot_invite_himself
  validate :cannot_invite_friends
  validate :cannot_invite_already_invited_user
  validate :cannot_invite_user_that_invited_you

  scope :to_user_id, -> (user_id) { where(to_user_id: user_id) }

  def accept!
    transaction do
      Friendship.create!(user: from_user, friend: to_user)
      Friendship.create!(user: to_user, friend: from_user)
      destroy!
    end
  end

  private

  def cannot_invite_himself
    if from_user == to_user
      errors[:to_user] << 'cannot invite yourself'
    end
  end

  def cannot_invite_friends
    if from_user.friends.exists?(to_user.id)
      errors[:to_user] << 'cannot invite friend'
    end
  end

  def cannot_invite_already_invited_user
    if FriendshipInvite.exists?(from_user: from_user, to_user: to_user)
      errors[:to_user] << 'user is already invited'
    end
  end

  def cannot_invite_user_that_invited_you
    if FriendshipInvite.exists?(from_user: to_user, to_user: from_user)
      errors[:to_user] << 'cannot invite user that invited you'
    end
  end
end
class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_create do
    Notification.create!(user: user,
                         type: 'NEW_FRIENDSHIP',
                         data: {friend: UserSerializer.new(friend).attributes})
  end

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: {scope: :user}

  scope :user_id, ->(user_id) { where(user_id: user_id) }

  def end!
    transaction do
      Friendship.find_by!(user: friend, friend: user).destroy!
      destroy!
    end
  end
end

class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: {scope: :user}

  scope :user_id, ->(user_id) { where(user_id: user_id) }

  def end!
    transaction do
      reverse.destroy!
      destroy!
    end
  end

  def reverse
    Friendship.find_by!(user: friend, friend: user)
  end

  def to_builder(controller, action)
    Jbuilder.new do |json|
      json.id id
      json.friend friend.to_builder(controller, action).attributes!
    end
  end
end

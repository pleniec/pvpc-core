class FriendshipInvite < ActiveRecord::Base
  belongs_to :from, class_name: 'User', foreign_key: :from_user_id
  belongs_to :to, class_name: 'User', foreign_key: :to_user_id

  default_scope { eager_load(:from, :to) }

  validates :from, presence: true
  validates :to, presence: true, uniqueness: {scope: :from}

  def accept!
    Friendship.create!(user: from, friend: to)
    Friendship.create!(user: to, friend: friend)
    destroy!
  end

  def reject!
    destroy!
  end

  def to_builder
    Jbuilder.new do |json|
      json.id id
      json.from { json.merge! from.to_builder.attributes! }
    end
  end
end

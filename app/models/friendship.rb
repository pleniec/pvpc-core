class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: {scope: :user}

  def destroy!
    transaction do
      Friendship.find_by!(user: friend, friend: user).destroy!
      super
    end
  end

  def to_builder
    Jbuilder.new do |json|
      json.id id
      json.friend { friend.to_builder.attributes! }
    end
  end
end

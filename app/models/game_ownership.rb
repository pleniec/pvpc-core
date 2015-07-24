class GameOwnership < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :nickname, presence: true
  validates :game, presence: true, uniqueness: {scope: :user}

  scope :user_id, ->(user_id) { where(user_id: user_id) }
end

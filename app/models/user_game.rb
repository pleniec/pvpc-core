class UserGame < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :nickname, presence: true
  validates :user, presence: true
  validates :game, presence: true
end

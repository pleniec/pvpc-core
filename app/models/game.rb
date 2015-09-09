class Game < ActiveRecord::Base
  has_many :game_rules

  validates :name, presence: true, uniqueness: true
end

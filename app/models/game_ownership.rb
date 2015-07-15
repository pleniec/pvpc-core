class GameOwnership < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :nickname, presence: true
  validates :game, presence: true, uniqueness: {scope: :user}

  scope :user_id, ->(user_id) { where(user_id: user_id) }

  def to_builder
    Jbuilder.new do |json|
      json.id id
      json.nickname nickname
      json.game do
        json.merge! game.to_builder.attributes!
      end
    end
  end
end

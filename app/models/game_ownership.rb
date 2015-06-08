class GameOwnership < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :nickname, presence: true
  validates :game, presence: true, uniqueness: {scope: :user}

  def to_builder
    Jbuilder.new do |json|
      json.id id
      json.game do
        json.merge! game.to_builder.attributes!
      end
    end
  end
end

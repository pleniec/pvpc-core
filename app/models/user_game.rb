class UserGame < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :nickname, presence: true
  validates :user, presence: true
  validates :game, presence: true, uniqueness: {scope: :user}

  default_scope { eager_load(game: {rules: :entries}) }

  def to_builder
    Jbuilder.new do |json|
      json.id id
      json.nickname nickname
      json.game game.to_builder.attributes!
    end
  end
end

module Games
  class UserGame < ActiveRecord::Base
    belongs_to :user, class_name: 'Users::User'
    belongs_to :game

    validates :nickname, presence: true
    validates :user, presence: true
    validates :game, presence: true, uniqueness: {scope: :user}

    default_scope { eager_load(game: {rules: :entries}) }

    def to_hash
      {id: id, nickname: nickname, game: game.to_simple_hash}
    end
  end
end

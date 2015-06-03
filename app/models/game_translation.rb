class GameTranslation < ActiveRecord::Base
  belongs_to :game

  validates :locale, presence: true
  validates :description, presence: true
end

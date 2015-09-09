class GameRule < ActiveRecord::Base
  belongs_to :game

  validates :game, presence: true
  validates :name, presence: true, uniqueness: {scope: :game}
  validate :properties_presence

  private

  def properties_presence
    errors[:properties] << "can't be blank" if properties.nil?
  end
end

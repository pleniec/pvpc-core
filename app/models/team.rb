class Team < ActiveRecord::Base
  belongs_to :founder, class_name: 'User'
  has_many :divisions
  has_many :team_memberships
  has_many :users, through: :team_memberships

  after_create { users << founder }

  validates :founder, presence: true

  scope :nickname, ->(nickname) { where(Team.arel_table[:nickname].matches("#{nickname}%")) }
end

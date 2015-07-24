class Team < ActiveRecord::Base
  belongs_to :founder, class_name: 'User'
  has_many :divisions
  has_many :team_memberships

  validates :founder, presence: true

  after_create do
    founder.teams << self
  end
end

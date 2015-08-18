class Team < ActiveRecord::Base
  belongs_to :founder, class_name: 'User'
  has_many :divisions
  has_many :team_memberships
  has_many :users, through: :team_memberships

  validates :founder, presence: true

  after_create { users << founder }
end

class Team < ActiveRecord::Base
  belongs_to :founder, class_name: 'User'
  has_many :team_memberships
  has_many :users, through: :team_memberships
  has_many :team_membership_requests
  has_many :comments, as: :commentable

  after_create { users << founder }

  validates :founder, presence: true

  scope :name_like, ->(name_prefix) { where('name LIKE ?', "#{name_prefix}%") }

  def captains
    team_memberships.where(captain: true).map(&:user)
  end
end

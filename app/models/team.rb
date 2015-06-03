class Team < ActiveRecord::Base
  belongs_to :founder, class_name: 'User'
  has_many :divisions
  has_many :team_memberships

  after_create do
    founder.teams << self
  end

  def to_simple_hash
    {id: id, name: name}
  end

  def to_detailed_hash
    to_simple_hash.merge(description: description, tag: tag, founder: founder.to_hash_without_access_token)
  end
end

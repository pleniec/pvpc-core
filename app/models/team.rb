class Team < ActiveRecord::Base
  belongs_to :founder, class_name: 'User'
  has_many :divisions
  has_many :team_memberships

  validates :founder, presence: true

  after_create do
    founder.teams << self
  end

  def to_builder(detailed = false)
    Jbuilder.new do |json|
      json.id id
      json.name name
      if detailed
        json.description description
        json.tag tag
        json.founder founder.to_builder.attributes!
      end
    end
  end
end

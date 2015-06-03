module Teams
  class UserTeam < ActiveRecord::Base
    belongs_to :user, class_name: 'Users::User'
    belongs_to :team, class_name: 'Teams::Team'

    validates :user, presence: true
    validates :team, presence: true

    def to_builder
      Jbuilder.new do |json|
        json.id id
        json.team team.to_builder.attributes!
      end
    end
  end
end

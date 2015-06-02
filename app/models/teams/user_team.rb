module Teams
  class UserTeam < ActiveRecord::Base
    belongs_to :user, class_name: 'Users::User'
    belongs_to :team, class_name: 'Teams::Team'

    validates :user, presence: true
    validates :team, presence: true
  end
end

module Teams
  class Team < ActiveRecord::Base
    belongs_to :founder, class_name: 'Users::User', foreign_key: :founder_id
  end
end

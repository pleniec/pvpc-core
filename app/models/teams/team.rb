module Teams
  class Team < ActiveRecord::Base
    belongs_to :founder, class_name: 'Users::User', foreign_key: :founder_id

    after_create do
      Teams::UserTeam.create!(user_id: founder_id, team_id: id)
    end

    def to_simple_hash
      {id: id, name: name}
    end

    def to_detailed_hash
      to_simple_hash.merge(description: description, tag: tag, founder: founder.to_hash_without_access_token)
    end
  end
end

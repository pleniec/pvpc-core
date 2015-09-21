require 'rails_helper'

RSpec.describe TeamMembershipProposition do
  describe '#accept!' do
    it 'creates team membership' do
      team_membership_proposition = FactoryGirl.create(:team_membership_proposition)

      team_membership_proposition.accept!

      expect(team_membership_proposition.team.users).to include(team_membership_proposition.user)
      expect(team_membership_proposition.destroyed?).to be true
    end
  end
end

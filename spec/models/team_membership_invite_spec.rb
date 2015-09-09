require 'rails_helper'

RSpec.describe TeamMembershipInvite do
  describe '#accept!' do
    it 'adds invited user to a team' do
      team = FactoryGirl.create(:team)
      user = FactoryGirl.create(:user)

      TeamMembershipInvite.create!(to_user: user, team: team).accept!

      expect(team.users).to include(user)
    end
  end
end

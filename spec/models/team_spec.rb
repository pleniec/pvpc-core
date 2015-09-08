require 'rails_helper'

RSpec.describe Team do
  context 'after create' do
    it 'adds founder to team members' do
      team = FactoryGirl.create(:team)

      expect(team.users).to include(team.founder)
    end
  end

  describe '.name_like' do
    it 'returns teams with matching name' do
      teams = [FactoryGirl.create(:team, name: 'team_odin'),
               FactoryGirl.create(:team, name: 'team_dwa'),
               FactoryGirl.create(:team, name: 'team_tri'),
               FactoryGirl.create(:team, name: 'szto?')]
      found_teams = Team.name_like('team')
      expect(found_teams).to include(*teams[0..2])
    end
  end
end

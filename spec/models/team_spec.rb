require 'rails_helper'

RSpec.describe Team do
  context 'after create' do
    it 'adds founder to team members' do
      team = FactoryGirl.create(:team)

      expect(team.users).to include(team.founder)
    end
  end

  describe '.nickname' do
    it 'returns teams with matching nickname' do
      teams = [FactoryGirl.create(:team, nickname: 'team_odin'),
               FactoryGirl.create(:team, nickname: 'team_dwa'),
               FactoryGirl.create(:team, nickname: 'team_tri'),
               FactoryGirl.create(:team, nickname: 'szto?')]
      found_teams = Team.nickname('team')
      expect(found_teams).to include(*teams[0..2])
    end
  end
end

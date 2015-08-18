require 'rails_helper'

RSpec.describe Team do
  context 'after create' do
    it 'adds founder to team members' do
      team = FactoryGirl.create(:team)

      expect(team.users).to include(team.founder)
    end
  end
end

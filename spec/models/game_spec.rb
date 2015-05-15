require 'rails_helper'

RSpec.describe Game do
  before do
    @game = FactoryGirl.create(:game)
  end

  it 'converts to json without rules' do
    expect(JSON.parse(@game.to_builder.target!)['rules']).to be nil
  end

  it 'converts to json with rules' do
    expect(JSON.parse(@game.to_builder(true).target!)['rules']).not_to be nil
  end
end

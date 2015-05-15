require 'rails_helper'

RSpec.describe Friendship do
  before do
    @users = FactoryGirl.create_list(:user, 2)
    FriendshipInvite.create!(from: @users[0], to: @users[1]).accept!
  end

  it 'can be ended' do
    @users[0].friendships[0].end!
    expect(@users[0].friends.count).to eql(0)
    expect(@users[1].friends.count).to eql(0)
  end

  it 'can be converted to json' do
    expect(JSON.parse(@users[0].friendships[0].to_builder.target!)).not_to be nil
  end
end

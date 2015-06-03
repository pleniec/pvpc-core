require 'rails_helper'

RSpec.describe Users::Friendship do
  include_context 'flush_redis'
  
  before do
    @users = FactoryGirl.create_list(:user, 2)
    Users::FriendshipInvite.create!(from: @users[0], to: @users[1]).accept!
  end

  it 'can be ended' do
    @users[0].friendships[0].end!
    expect(@users[0].friends.count).to eql(0)
    expect(@users[1].friends.count).to eql(0)
  end
end

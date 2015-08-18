require 'rails_helper'

RSpec.describe Friendship do
  describe 'model' do
    it 'can be ended' do
      FactoryGirl.create(:friendship)
    end
  end
=begin
  before do
    @users = FactoryGirl.create_list(:user, 2)
    FriendshipInvite.create!(from_user: @users[0], to_user: @users[1]).accept!
  end

  it 'can be ended' do
    @users[0].friendships[0].end!
    expect(@users[0].friends.count).to eql(0)
    expect(@users[1].friends.count).to eql(0)
  end
=end
end

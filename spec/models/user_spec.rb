require 'rails_helper'

RSpec.describe User do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe 'authentication' do
    it 'returns user on valid credentials' do
      authentication_result = User.authenticate(@user.email, 'password123')
      expect(authentication_result).to eql(@user)
    end
  end

  describe 'token authentication' do
    it 'returns nil on invalid access token' do
      access_tokens = [nil, 'invalidaccesstoken']
      access_tokens.each do |access_token|
        expect(Session.new(access_token: access_token).to_user).to be nil
      end
    end

    it 'returns user on valid access token' do
      expect(Session.new(access_token: @user.session.access_token).to_user).to eql(@user)
    end
  end

  it 'can be created' do
    expect(@user.persisted?).to be true
  end

  it 'has access token after create' do
    expect(@user.session.access_token).to_not be nil
  end

  it 'has flags' do
    expect(@user.flags.play_message_sound).to be false
  end

  it 'can update flags' do
    @user.flags.play_message_sound = true
    @user.save!

    expect(User.find(@user.id).flags.play_message_sound).to be true
  end
end

require 'rails_helper'

RSpec.describe Users::User do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe 'authentication' do
    it 'raises User::InvalidCredentials on invalid credentials' do
      credentials = [[nil, nil], [@user.email, nil], [nil, 'password123'], [@user.email, 'password1234']]
      credentials.each do |email, password|
        expect { Users::User.authenticate(email, password) }.to raise_error(Users::User::InvalidCredentials)
      end
    end

    it 'returns user on valid credentials' do
      authentication_result = Users::User.authenticate(@user.email, 'password123')
      expect(authentication_result).to eql(@user)
    end
  end

  describe 'token authentication' do
    it 'returns nil on invalid access token' do
      access_tokens = [nil, 'invalidaccesstoken']
      access_tokens.each do |access_token|
        expect(Users::Session.new(access_token: access_token).to_user).to be nil
      end
    end

    it 'returns user on valid access token' do
      expect(Users::Session.new(access_token: @user.session.access_token).to_user).to eql(@user)
    end
  end

  it 'can be created' do
    expect(@user.persisted?).to be true
  end

  it 'has access token after create' do
    expect(@user.session.access_token).to_not be nil
  end

  it 'converts to json without access token' do
    expect(JSON.parse(@user.to_builder.target!)['access_token']).to be nil
  end 

  it 'converts to json with access token' do
    expect(JSON.parse(@user.to_builder(true).target!)['access_token']).not_to be nil
  end 
end

require 'rails_helper'

RSpec.describe User do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe 'authentication' do
    it 'raises User::InvalidCredentials on invalid credentials' do
      credentials = [[nil, nil], [@user.email, nil], [nil, 'password123'], [@user.email, 'password1234']]
      credentials.each do |email, password|
        expect { User.authenticate(email, password) }.to raise_error(User::InvalidCredentials)
      end
    end

    it 'returns user on valid credentials' do
      authentication_result = User.authenticate(@user.email, 'password123')
      expect(authentication_result).to eql(@user)
    end
  end

  describe 'token authentication' do
    it 'returns nil on invalid access token' do
      access_tokens = [nil, 'invalidaccesstoken']
      access_tokens.each do |access_token|
        expect(User.authenticate_with_access_token(access_token)).to be nil
      end
    end

    it 'returns user on valid access token' do
      expect(User.authenticate_with_access_token(@user.access_token)).to eql(@user)
    end
  end

  it 'can be created' do
    expect(@user.persisted?).to be true
  end

  it 'has access token after create' do
    expect(@user.access_token).to_not be nil
  end

  it 'generates access token' do
    old_access_token = @user.access_token
    @user.generate_access_token!
    expect(@user.access_token).not_to eql(old_access_token)
  end

  it 'converts to json without access token' do
    expect(JSON.parse(@user.to_builder.target!)['access_token']).to be nil
  end 

  it 'converts to json with access token' do
    expect(JSON.parse(@user.to_builder(true).target!)['access_token']).not_to be nil
  end 
end

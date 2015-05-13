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

  it 'can be created' do
    expect(@user.persisted?).to be true
  end

  it 'generates access token' do
    @user.generate_access_token!
    expect(@user.access_token).not_to be nil
  end
end

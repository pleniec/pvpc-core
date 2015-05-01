require 'rails_helper'

RSpec.describe User do
  before :each do
    @email = 'user@mail.com'
    @password = 'password123'
    @user = User.create(email: @email, password: @password)
  end

  describe 'authentication' do
    it 'returns nil on nil email' do
      authentication_result = User.authenticate(nil, @password)
      expect(authentication_result).to be nil
    end

    it 'returns nil on invalid credentials' do
      authentication_result = User.authenticate(@email, 'password1234')
      expect(authentication_result).to be nil
    end

    it 'returns user on valid credentials' do
      authentication_result = User.authenticate(@email, @password)
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

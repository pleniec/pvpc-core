require 'rails_helper'

RSpec.describe Api::Private::UsersController do
  include_context 'private/authenticated'

  before do
    @user = FactoryGirl.create(:user)
  end

  it 'does not return user with id on invalid access token' do
    get :token_check, access_token: 'impossibru!', format: :json
    expect(response.status).to eql(404)
  end

  it 'returns user with id on valid access token' do
    get :token_check, access_token: @user.access_token, format: :json
    expect(response.status).to eql(200)
    expect(JSON.parse(response.body)['user']['id']).to eql(@user.id)
  end
end

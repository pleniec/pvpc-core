require 'rails_helper'

RSpec.describe Public::TeamsController do
  before do
    @user = FactoryGirl.create(:user)
    @teams = FactoryGirl.create_list(:team, 3, founder: @user)
  end

  describe 'GET #index' do
    it 'renders teams' do
      get_json :index, access_token: @user.session.access_token
      expect(response.status).to eql(200)
      expect(response_body['models'].size).to eql(3)
    end
  end

  describe 'GET #show' do
    it 'renders team' do
      get_json :show, access_token: @user.session.access_token, id: @teams[0].id
      expect(response.status).to eql(200)
      expect(response_body.keys.size).to be > 2
    end
  end

  describe 'POST #create' do
    it 'creates team' do
      post_json :create, access_token: @user.session.access_token,
        model: {name: 'tim', description: 'nice team', tag: 'hdp', founder_id: @user.id}
      expect(response.status).to eql(201)
      expect(Team.count).to eql(4)
    end

    it 'cannot create team as other user' do
      @other_user = FactoryGirl.create(:user)
      post_json :create, access_token: @user.session.access_token,
        model: {name: 'tim', description: 'nice team', tag: 'hdp', founder_id: @other_user.id}
      expect(response.status).to eql(403)
      expect(Team.count).to eql(3)
    end
  end
end

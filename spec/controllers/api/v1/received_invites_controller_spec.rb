require 'rails_helper'

RSpec.describe API::V1::ReceivedInvitesController do
  describe 'GET #index' do
    it 'lols' do
      ActiveRecord::Base.logger = Logger.new(STDOUT)
      get_json :index, user_id: @users[0].id, access_token: @users[0].session.access_token
      puts response.status
      puts response.body
    end
  end
end

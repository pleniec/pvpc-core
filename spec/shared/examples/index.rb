RSpec.shared_examples :index do |options|
  describe '#index' do
    before do
      @user = FactoryGirl.create(:user)
      @models = FactoryGirl.create_list(options[:model], 5)
    end

    it 'renders models' do
      params = {access_token: @user.session.access_token}
      params.merge!(options.fetch(:scopes, []).map { |s| [s, @models.first.send(s)] }.to_h)
      index params

      expect(response.status).to eql 200
      expect(response_body['models'].size).to be > 0
    end
  end
end

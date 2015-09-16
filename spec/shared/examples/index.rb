RSpec.shared_examples :index do |options|
  describe '#index' do
    before do
      @user = FactoryGirl.create(:user)
      @models = FactoryGirl.create_list(subject.model_class.name.downcase, 5)
    end

    it 'renders models' do
      scopes = (subject.scopes_configuration.keys - [:limit, :offset])
        .map { |s| [s, @models.first.send(s)] }
        .to_h


      params = {access_token: @user.session.access_token}
      params.merge!(options.fetch(:scopes, []).map { |s| [s, @models.first.send(s)] }.to_h)
      index params

      expect(response.status).to eql 200
      expect(response_body['models'].size).to be > 0
    end
  end
end

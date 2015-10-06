RSpec.shared_examples :update do |options = {}|
  describe '#update' do
    before { @user = FactoryGirl.create(:user) }

    context 'when authorized user attempts to update model' do
      it 'updates model' do
        model = options[:create_permitted_model].(@user)
        params = options[:params]

        update params.merge(access_token: @user.session.access_token, id: model.id)

        expect(response.status).to eql 204
      end
    end

    context 'when unauthorized user attempts to update model' do
      it 'renders forbidden status' do
        model = options[:create_forbidden_model].(@user)
        params = options[:params]

        update params.merge(access_token: @user.session.access_token, id: model.id)

        expect(response.status).to eql 403
      end
    end
  end
end

RSpec.shared_examples :index do |options|
  describe '#index' do
    before { @user = FactoryGirl.create(:user) }

    context 'when authorized user attempts to list models' do
      it 'renders models' do
        model = options[:create_permitted_model].(@user)

        index options[:permitted_params].merge(access_token: @user.session.access_token)

        expect(response.status).to eql 200
        expect(response_body['total']).to eql 1
        expect(response_body['models'][0]['id']).to eql model.id
      end
    end

    context 'when unauthorized user attempts to list models' do
      it 'renders forbidden status' do
        model = options[:create_forbidden_model].(@user)

        index options[:forbidden_params].merge(access_token: @user.session.access_token)

        expect(response.status).to eql 403
      end
    end
  end
end

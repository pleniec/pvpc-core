RSpec.shared_examples :index do |options|
  describe '#index' do
    before { @user = FactoryGirl.create(:user) }

    context 'when authorized user attempts to list models' do
      it 'renders models' do
        model = options[:create_permitted_model].(@user)

        index options[:permitted_params].(model).merge(access_token: @user.session.access_token)

        expect(response.status).to eql 200
        expect(response_body['meta']['total']).to eql 1
        expect(response_body['models'][0]['id']).to eql model.id
      end
    end

    if options[:create_forbidden_model] && options[:forbidden_params]
      context 'when unauthorized user attempts to list models' do
        it 'renders forbidden status' do
          model = options[:create_forbidden_model].(@user)

          index options[:forbidden_params].(model).merge(access_token: @user.session.access_token)

          expect(response.status).to eql 403
        end
      end
    end
  end
end

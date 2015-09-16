RSpec.shared_examples :create do |options|
  describe '#create' do
    before { @user = FactoryGirl.create(:user) }

    context 'with permitted parameters' do
      it 'creates model' do
        create options[:permitted_params].(@user).merge(access_token: @user.session.access_token)

        expect(response.status).to eql 201
        expect(subject.model_class.exists?(response_body['id'])).to be true
      end
    end

    context 'with forbidden parameters' do
      it 'renders forbidden status' do
        create options[:forbidden_params].(@user).merge(access_token: @user.session.access_token)

        expect(response.status).to eql 403
        expect(subject.model_class.exists?(response_body['id'])).to be false
      end
    end
  end
end

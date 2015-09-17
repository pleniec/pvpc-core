RSpec.shared_examples :show do |options|
  describe '#show' do
    before { @user = FactoryGirl.create(:user) }

    context 'when authorized user attempts to show model' do
      it 'renders model' do
        @model = options[:create_permitted_model].(@user)

        show access_token: @user.session.access_token, id: @model.id

        expect(response.status).to eql 200
      end
    end

    if options[:create_forbidden_model]
      context 'when unauthorized user attempts to show model' do
        it 'renders forbidden status' do
          @model = options[:create_forbidden_model].(@user)

          show access_token: @user.session.access_token, id: @mode.id

          expect(response.status).to eql 403
        end
      end
    end
  end
end

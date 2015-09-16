RSpec.shared_examples :destroy do |options|
  describe '#destroy' do
    before { @user = FactoryGirl.create(:user) }

    context 'when authorized user attempts to destroy model' do
      it 'destroys model' do
        @model = options[:create_permitted_model].(@user)

        destroy access_token: @user.session.access_token, id: @model.id

        expect(response.status).to eql 204
        expect(@model.class.exists?(@model.id)).to be false
      end
    end

    context 'when unauthorized user attempts to destroy model' do
      it 'renders forbidden status' do
        @model = options[:create_forbidden_model].(@user)

        destroy access_token: @user.session.access_token, id: @model.id

        expect(response.status).to eql 403
        expect(@model.class.exists?(@model.id)).to be true
      end
    end
  end
end

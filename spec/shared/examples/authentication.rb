RSpec.shared_examples :authentication do |options|
  (options[:restricted] || []).each do |action, method|
    describe "##{action}" do
      before { @model = FactoryGirl.create(subject.model_class.name.underscore.to_sym) }

      context 'with access_token parameter' do
        it "doesn't render unauthorized status" do
          user = FactoryGirl.create(:user)
          send(method, action, format: :json, id: @model.id, access_token: user.session.access_token)

          expect(response.status).not_to eql 401
        end
      end

      context 'without access_token parameter' do
        it 'renders unauthorized status' do
          send(method, action, format: :json, id: @model.id)
          
          expect(response.status).to eql 401
        end
      end
    end
  end

  (options[:free] || []).each do |action, method|
    describe "##{action}" do
      before { @model = FactoryGirl.create(subject.model_class.name.underscore.to_sym) }

      context 'with access_token parameter' do
        it "doesn't render unauthorized status" do
          user = FactoryGirl.create(:user)
          send(method, action, format: :json, id: @model.id, access_token: user.session.access_token)

          expect(response.status).not_to eql 401
        end
      end

      context 'without access_token parameter' do
        it "does'n render unauthorized status" do
          send(method, action, format: :json, id: @model.id)
          
          expect(response.status).not_to eql 401
        end
      end
    end
  end
end

RSpec.shared_context 'token_authenticated' do
  before :each do
    @current_user = FactoryGirl.create(:user)
  end
end
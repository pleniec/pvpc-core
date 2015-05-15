RSpec.shared_context 'token_authenticated' do
  before do
    @users = FactoryGirl.create_list(:user, 3)
  end
end
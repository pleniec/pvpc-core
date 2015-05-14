RSpec.shared_context 'token_authenticated' do
  before :each do
    @users = FactoryGirl.create_list(:user, 2)
  end
end
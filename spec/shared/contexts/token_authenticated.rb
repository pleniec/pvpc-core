RSpec.shared_context 'token_authenticated' do
  before :each do
    user = FactoryGirl.create(:user)
    @access_token = user.generate_access_token!
    user.save!
  end
end
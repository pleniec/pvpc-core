RSpec.shared_context 'authenticated' do
  include_context 'http_authenticated', 'pvpc', 'pefalpe987'

  before do
    @users = FactoryGirl.create_list(:user, 5)
  end
end

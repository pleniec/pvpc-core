RSpec.shared_context 'public/authenticated' do
  include_context 'http_authenticated', 'pvpc', 'pefalpe987'

  before do
    @users = FactoryGirl.create_list(:user, 3)
  end
end

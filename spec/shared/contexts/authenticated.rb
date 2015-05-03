RSpec.shared_context 'authenticated' do
  include_context 'http_authenticated'
  include_context 'access_token_authenticated'
end

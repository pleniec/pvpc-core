RSpec.shared_context 'private/authenticated' do
  include_context 'http_authenticated', 'pvpc-secret', 'pefalpe987'
end

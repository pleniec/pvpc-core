RSpec.shared_context 'with_basic_authentication' do
  before :each do
    @name = 'pvpc'
    @password = 'pefalpe987'
    http_authorization = 'Basic ' + Base64::encode64("#{@name}:#{@password}")
    request.env["HTTP_AUTHORIZATION"] = http_authorization
  end
end
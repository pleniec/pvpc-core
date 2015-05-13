RSpec.shared_context 'http_authenticated' do
  before do
    http_authorization = 'Basic ' + Base64::encode64("pvpc:pefalpe987")
    request.env["HTTP_AUTHORIZATION"] = http_authorization
  end
end
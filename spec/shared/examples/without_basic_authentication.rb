RSpec.shared_examples 'without_basic_authentication' do |actions|
  context 'without basic authentication' do
    actions.each do |action, method|
      it "#{method.upcase} #{action}" do
        send(method, action)
        expect(response.status).to be 401
      end
    end
  end
end
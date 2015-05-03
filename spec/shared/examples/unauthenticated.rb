RSpec.shared_examples 'unauthenticated' do |actions_with_options|
  context 'unauthenticated (http)' do
    actions_with_options.each do |action, options|
      it "#{options[:method].upcase} #{action}" do
        send(options[:method], action, options.except(:methods))
        expect(response.status).to be 401
      end
    end
  end

  context 'unauthenticated (token)' do
    include_context 'http_authenticated'

    actions_with_options.each do |action, options|
      it "#{options[:method].upcase} #{action}" do
        send(options[:method], action, options.except(:methods))
        expect(response.status).to be 401
      end
    end
  end 
end

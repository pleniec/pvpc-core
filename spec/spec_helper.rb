require 'helper'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before type: :controller do
    request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64('pvpc:pefalpe987')
  end

  config.after do
    Redis.current.flushall
  end

  config.include Helper
  Dir["./spec/shared/**/*.rb"].sort.each { |f| require f }
end

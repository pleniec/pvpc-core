RSpec.shared_context 'flush_redis' do
  after do
    Redis.current.flushall
  end
end

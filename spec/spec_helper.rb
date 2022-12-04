$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'webmock/rspec'
require 'fitbit_api'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.filter_run_when_matching(:focus)

  config.before(:each) do
    WebMock.reset!
  end

  config.after(:each) do
    WebMock.reset!
  end

  def stub_client_request(client, verb, path)
    stub_request(verb, "https://api.fitbit.com/#{client.api_version}/#{path}")
  end

  def fixture(file_path)
    File.new(File.join(fixture_path, '/', file_path))
  end

  def fixture_path
    File.expand_path('../fixtures', __FILE__)
  end
end

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

  def build_client(options = {})
    allow_any_instance_of(OAuth2::AccessToken).to receive(:refresh!) { |token| token }

    FitbitAPI::Client.new(
      client_id: options[:client_id] || 'ABC123',
      client_secret: options[:client_secret] || 'xyz789',
      refresh_token: options[:refresh_token] || 'xxxxxx',
      user_id: options[:user_id] || '-'
    )
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

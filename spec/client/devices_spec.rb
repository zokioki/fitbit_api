require 'spec_helper'

describe FitbitAPI::Client do
  let(:client) { build_client }

  describe '#devices' do
    it 'fetches list of devices paired to user\'s account' do
      path = 'user/-/devices.json'
      response_body = fixture('devices/list.json').read

      stub_client_request(client, :get, path).to_return(body: response_body)
      response = client.devices

      expect(response).to eq(JSON.parse(response_body))
    end
  end
end

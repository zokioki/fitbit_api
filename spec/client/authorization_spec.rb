# frozen_string_literal: true

require 'spec_helper'

describe FitbitAPI::Client do
  let(:client) do
    FitbitAPI::Client.new(client_id: 'ABC123', client_secret: 'xyz789')
  end

  describe '.auth_url' do
    context 'with default response_type' do
      let(:expected_url) do
        "https://www.fitbit.com/oauth2/authorize?client_id=ABC123&redirect_uri&response_type=code&scope=activity+nutrition+profile+settings+sleep+social+weight+heartrate"
      end

      it 'uses code as response_type' do
        expect(client.auth_url).to eq expected_url
      end
    end

    context 'with response_type' do
      %w[code token].each do |response_type|
        context "with #{response_type} response_type" do
          let(:expected_url) do
            "https://www.fitbit.com/oauth2/authorize?client_id=ABC123&redirect_uri&response_type=#{response_type}&scope=activity+nutrition+profile+settings+sleep+social+weight+heartrate"
          end

          it "uses #{response_type} as response_type" do
            expect(client.auth_url(response_type: response_type)).to eq expected_url
          end
        end
      end
    end
  end
end

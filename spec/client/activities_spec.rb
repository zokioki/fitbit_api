# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FitbitAPI::Client do
  let(:client) { build_client }

  describe '#daily_activity_summary' do
    it 'fetches activity summary for given date' do
      date = '2022-01-01'
      path = "user/-/activities/date/#{date}.json"
      response_body = fixture('activities/daily.json').read

      stub_client_request(client, :get, path).to_return(body: response_body)
      response = client.daily_activity_summary(date)

      expect(response).to eq(JSON.parse(response_body))
    end

    it 'fetches activity summary for today\'s date if none given' do
      today = Date.today.strftime('%Y-%m-%d')
      path = "user/-/activities/date/#{today}.json"
      response_body = fixture('activities/daily.json').read

      stub_client_request(client, :get, path).to_return(body: response_body)
      response = client.daily_activity_summary

      expect(response).to eq(JSON.parse(response_body))
    end
  end

  describe '#frequent_activities' do
    it 'fetches list of user\'s frequent activities' do
      path = 'user/-/activities/frequent.json'
      response_body = fixture('activities/frequent.json').read

      stub_client_request(client, :get, path).to_return(body: response_body)
      response = client.frequent_activities

      expect(response).to eq(JSON.parse(response_body))
    end
  end

  describe '#recent_activities' do
    it 'fetches list of user\'s recent activities' do
      path = 'user/-/activities/recent.json'
      response_body = fixture('activities/recent.json').read

      stub_client_request(client, :get, path).to_return(body: response_body)
      response = client.recent_activities

      expect(response).to eq(JSON.parse(response_body))
    end
  end

  describe '#favorite_activities' do
    it 'fetches list of user\'s favorite activities' do
      path = 'user/-/activities/favorite.json'
      response_body = fixture('activities/favorite.json').read

      stub_client_request(client, :get, path).to_return(body: response_body)
      response = client.favorite_activities

      expect(response).to eq(JSON.parse(response_body))
    end
  end

  describe '#all_activities' do
    it 'fetches list of all valid public and private user-created activities' do
      path = 'activities.json'
      response_body = fixture('activities/all.json').read

      stub_client_request(client, :get, path).to_return(body: response_body)
      response = client.all_activities

      expect(response).to eq(JSON.parse(response_body))
    end
  end
end

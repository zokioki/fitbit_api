require 'spec_helper'

describe FitbitAPI::Client do
  let(:client) do
    FitbitAPI::Client.new(client_id: 'ABC123', client_secret: 'xyz789', user_id: '-')
  end

  describe '#daily_activity_summary' do
    it 'makes a request to the correct URL for today\'s date' do
      today = Date.today.strftime('%Y-%m-%d')
      expect(client).to receive(:get).with("user/-/activities/date/#{today}.json")

      client.daily_activity_summary
    end

    it 'makes a request to the correct URL for the given date' do
      date = '2022-01-01'
      expect(client).to receive(:get).with("user/-/activities/date/#{date}.json")

      client.daily_activity_summary(date)
    end
  end

  describe '#frequent_activities' do
    it 'makes a request to the correct URL' do
      expect(client).to receive(:get).with('user/-/activities/frequent.json')
      client.frequent_activities
    end
  end

  describe '#recent_activities' do
    it 'makes a request to the correct URL' do
      expect(client).to receive(:get).with('user/-/activities/recent.json')
      client.recent_activities
    end
  end

  describe '#favorite_activities' do
    it 'makes a request to the correct URL' do
      expect(client).to receive(:get).with('user/-/activities/favorite.json')
      client.favorite_activities
    end
  end

  describe '#all_activities' do
    it 'makes a request to the correct URL' do
      expect(client).to receive(:get).with('activities.json')
      client.all_activities
    end
  end
end

# frozen_string_literal: true

module FitbitAPI
  class Client
    # Retrieves a list of subscriptions created by your application for a specific user.
    # You can either fetch subscriptions for a specific collection or the entire list
    # of subscriptions for the user.
    #
    # @param collection_path [String] Collection of data to retrieve notifications

    def subscriptions(collection_path = nil)
      get("#{subscriptions_path(collection_path)}.json")
    end

    # Creates a subscription to notify the application when a user has new data available.
    #
    # @param subscription_id [Integer] The unique ID of the subscription created by the API client application
    # @param collection_path [String] Collection of data to retrieve notifications

    def create_subscription(subscription_id, collection_path = nil)
      post("#{subscriptions_path(collection_path)}/#{subscription_id}.json")
    end

    # Deletes a subscription for a specific user.
    #
    # @param subscription_id [Integer] The unique ID of the subscription created by the API client application
    # @param collection_path [String] Collection of data to retrieve notifications

    def delete_subscription(subscription_id, collection_path = nil)
      delete("#{subscriptions_path(collection_path)}/#{subscription_id}.json")
    end

    private

    def subscriptions_path(collection_path = nil)
      collection_path = "#{collection_path}/" if collection_path
      "user/#{user_id}/#{collection_path}apiSubscriptions"
    end
  end
end

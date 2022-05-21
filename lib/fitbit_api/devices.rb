module FitbitAPI
  class Client
    # Retrieves a list of Fitbit devices paired to a user's account.

    def devices
      get("user/#{user_id}/devices.json")
    end
  end
end

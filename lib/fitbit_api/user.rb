module FitbitAPI
  class Client
    # Retrieves the user's profile data.

    def profile
      get("user/#{user_id}/profile.json")
    end

    # Retrieves a list of the user's badges.

    def badges
      get("user/#{user_id}/badges.json")
    end

    # Modifies a user's profile data.
    #
    # @params body [Hash] The POST request body

    def update_profile(body)
      post("user/#{user_id}/profile.json", body)
    end
  end
end

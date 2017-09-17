module FitbitAPI
  class Client
    def profile(opts={})
      get("user/#{user_id}/profile.json", opts)
    end

    def badges(opts={})
      get("user/#{user_id}/badges.json", opts)
    end

    def update_profile(opts)
      post("user/#{user_id}/profile.json", opts)
    end
  end
end

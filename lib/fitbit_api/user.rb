module FitbitAPI
  class Client
    def profile
      get("user/#{user_id}/profile.json")
    end

    def badges
      get("user/#{user_id}/badges.json")
    end

    def update_profile(body)
      post("user/#{user_id}/profile.json", body)
    end
  end
end

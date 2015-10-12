module Fitbyte
  class Client
    def profile
      get("user/#{@user_id}/profile.json")
    end

    def badges
      get("user/#{@user_id}/badges.json")
    end
  end
end

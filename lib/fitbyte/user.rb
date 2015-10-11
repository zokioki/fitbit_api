module Fitbyte
  class Client
    def profile
      get("user/-/profile.json")
    end

    def badges
      get("user/-/badges.json")
    end
  end
end

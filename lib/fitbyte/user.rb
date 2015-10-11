module Fitbyte
  class Client
    def profile
      get("1/user/-/profile.json")
    end

    def badges
      get("1/user/-/badges.json")
    end
  end
end

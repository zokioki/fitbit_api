module Fitbyte
  class Client
    def friends
      get("user/-/friends.json")
    end

    def friends_leaderboard
      get("user/-/friends/leaderboard.json")
    end
  end
end

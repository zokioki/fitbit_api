module Fitbyte
  class Client
    def friends
      get("1/user/-/friends.json")
    end

    def friends_leaderboard
      get("1/user/-/friends/leaderboard.json")
    end
  end
end

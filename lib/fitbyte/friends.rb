module Fitbyte
  class Client
    def friends
      get("user/#{@user_id}/friends.json")
    end

    def friends_leaderboard
      get("user/#{@user_id}/friends/leaderboard.json")
    end
  end
end

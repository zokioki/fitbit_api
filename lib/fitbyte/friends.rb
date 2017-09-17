module FitbitAPI
  class Client
    def friends(opts={})
      get("user/#{user_id}/friends.json", opts)
    end

    def friends_leaderboard(opts={})
      get("user/#{user_id}/friends/leaderboard.json", opts)
    end
  end
end

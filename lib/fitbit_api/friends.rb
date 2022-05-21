module FitbitAPI
  class Client
    # Retrieves a list of the Fitbit user's friends.

    def friends
      get("user/#{user_id}/friends.json")
    end

    # Retrieves the user's friends leaderboard.

    def friends_leaderboard
      get("user/#{user_id}/friends/leaderboard.json")
    end
  end
end

module Fitbyte
  class Client
    def food_logs(date=Date.today)
      get("user/#{@user_id}/foods/log/date/#{format_date(date)}.json")
    end

    def recent_foods
      get("user/#{@user_id}/foods/recent.json")
    end

    def frequent_foods
      get("user/#{@user_id}/foods/log/frequent.json")
    end

    def favorite_foods
      get("user/#{@user_id}/foods/log/favorite.json")
    end

    def food_goals
      get("user/#{@user_id}/foods/log/goal.json")
    end
  end
end

module Fitbyte
  class Client
    def food_logs(date=Date.today, opts={})
      get("user/#{@user_id}/foods/log/date/#{format_date(date)}.json", opts)
    end

    def recent_foods(opts={})
      get("user/#{@user_id}/foods/log/recent.json", opts)
    end

    def frequent_foods(opts={})
      get("user/#{@user_id}/foods/log/frequent.json", opts)
    end

    def favorite_foods(opts={})
      get("user/#{@user_id}/foods/log/favorite.json", opts)
    end

    def food_goals(opts={})
      get("user/#{@user_id}/foods/log/goal.json", opts)
    end
  end
end

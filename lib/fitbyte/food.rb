module Fitbyte
  class Client
    def food_logs(date=Date.today)
      get("user/-/foods/log/date/#{format_date(date)}.json")
    end

    def recent_foods
      get("user/-/foods/recent.json")
    end

    def frequent_foods
      get("user/-/foods/log/frequent.json")
    end

    def favorite_foods
      get("user/-/foods/log/favorite.json")
    end

    def food_goals
      get("user/-/foods/log/goal.json")
    end
  end
end

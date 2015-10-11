module Fitbyte
  class Client
    def food_logs(date=Date.today)
      get("1/user/-/foods/log/date/#{format_date(date)}.json")
    end

    def recent_foods
      get("1/user/-/foods/recent.json")
    end

    def frequent_foods
      get("1/user/-/foods/log/frequent.json")
    end

    def favorite_foods
      get("1/user/-/foods/log/favorite.json")
    end
  end
end

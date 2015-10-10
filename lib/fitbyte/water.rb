module Fitbyte
  class Client
    def water_logs(date)
      get("1/user/-/foods/log/water/date/#{format_date(date)}.json")
    end
    end
  end
end

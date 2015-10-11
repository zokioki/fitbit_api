module Fitbyte
  class Client
    def water_logs(date=Date.today)
      get("user/-/foods/log/water/date/#{format_date(date)}.json")
    end
  end
end

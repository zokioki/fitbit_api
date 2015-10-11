module Fitbyte
  class Client
    def weight_logs(date=Date.today)
      get("1/user/-/body/log/weight/date/format_date(date).json")
    end

    def body_fat_logs(date=Date.today)
      get("1/user/-/body/log/fat/date/#{format_date(date)}.json")
    end

    def weight_goals
      get("1/user/-/body/log/weight/goal.json")
    end

    def body_fat_goals
      get("1/user/-/body/log/fat/goal.json")
    end
  end
end

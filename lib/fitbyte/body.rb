module Fitbyte
  class Client
    def weight_logs(date=Date.today, opts={})
      get("user/-/body/log/weight/date/#{format_date(date)}.json", opts)
    end

    def body_fat_logs(date=Date.today, opts={})
      get("user/-/body/log/fat/date/#{format_date(date)}.json", opts)
    end

    def weight_goals(opts={})
      get("user/-/body/log/weight/goal.json", opts)
    end

    def body_fat_goals(opts={})
      get("user/-/body/log/fat/goal.json", opts)
    end
  end
end

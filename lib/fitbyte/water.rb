module FitbitAPI
  class Client
    def water_logs(date=Date.today, opts={})
      get("user/#{user_id}/foods/log/water/date/#{format_date(date)}.json", opts)
    end
  end
end

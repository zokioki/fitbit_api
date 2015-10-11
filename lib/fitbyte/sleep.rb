module Fitbyte
  class Client
    def sleep_logs(date=Date.today)
      get("user/-/sleep/date/#{format_date(date)}.json")
    end
  end
end

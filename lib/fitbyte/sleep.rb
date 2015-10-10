module Fitbyte
  class Client
    def sleep_logs(date)
      get("1/user/-/sleep/date/#{format_date(date)}.json")
    end
  end
end

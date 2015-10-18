module Fitbyte
  class Client
    def sleep_logs(date=Date.today, opts={})
      get("user/#{@user_id}/sleep/date/#{format_date(date)}.json", opts)
    end
  end
end

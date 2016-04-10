module Fitbyte
  class Client
    def heart_rate_time_series(opts={})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      if [period, start_date].none?
        raise Fitbyte::InvalidArgumentError, "A start_date or period is required."
      end

      if period && !PERIODS.include?(period)
        raise Fitbyte::InvalidArgumentError, "Invalid period: \"#{period}\". Please provide one of the following: #{PERIODS}."
      end

      if period
        result = get("user/#{@user_id}/activities/heart/date/#{format_date(end_date)}/#{period}.json", opts)
      else
        result = get("user/#{@user_id}/activities/heart/date/#{format_date(start_date)}/#{format_date(end_date)}.json", opts)
      end
      # remove root key from response
      result.values[0]
    end
  end
end

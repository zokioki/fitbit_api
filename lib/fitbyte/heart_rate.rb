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
        result = get("user/#{user_id}/activities/heart/date/#{format_date(end_date)}/#{period}.json", opts)
      else
        result = get("user/#{user_id}/activities/heart/date/#{format_date(start_date)}/#{format_date(end_date)}.json", opts)
      end
      # remove root key from response
      result.values[0]
    end

    def heart_rate_intraday_time_series(opts={})
      date         = opts[:date] || Date.today
      detail_level = opts[:detail_level]
      start_time   = opts[:start_time]
      end_time     = opts[:end_time]

      if [detail_level, date].any?(&:nil?)
        raise Fitbyte::InvalidArgumentError, "A date and detail_level are required."
      end

      if %(1sec 1min).include? detail_level
        raise Fitbyte::InvalidArgumentError, "Invalid detail_level: \"#{detail_level}\". Please provide one of the following: \"1sec\" or \"1min\"."
      end

      if (start_time || end_time) && !(start_time && end_time)
        raise Fitbyte::InvalidArgumentError, "Both start_time and end_time are required if time is being specified."
      end

      if (start_time && end_time)
        result = get("user/-/activities/heart/date/#{format_date(date)}/1d/#{detail_level}/time/#{format_time(start_time)}/#{format_time(end_time)}.json")
      else
        result = get("user/-/activities/heart/date/#{format_date(date)}/1d/#{detail_level}.json")
      end
      # remove root key from response
      result.values[0]
    end
  end
end

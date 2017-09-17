module FitbitAPI
  class Client
    def heart_rate_time_series(opts={})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      if [period, start_date].none?
        raise FitbitAPI::InvalidArgumentError, 'A start_date or period is required.'
      end

      if period && !PERIODS.include?(period)
        raise FitbitAPI::InvalidArgumentError, "Invalid period: \"#{period}\". Please provide one of the following: #{PERIODS}."
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

      if [date, detail_level].any?(&:nil?)
        raise FitbitAPI::InvalidArgumentError, 'A date and detail_level are required.'
      end

      unless %(1sec 1min).include? detail_level
        raise FitbitAPI::InvalidArgumentError, "Invalid detail_level: \"#{detail_level}\". Please provide one of the following: \"1sec\" or \"1min\"."
      end

      if (start_time || end_time) && !(start_time && end_time)
        raise FitbitAPI::InvalidArgumentError, 'Both start_time and end_time are required if time is being specified.'
      end

      if (start_time && end_time)
        get("user/-/activities/heart/date/#{format_date(date)}/1d/#{detail_level}/time/#{format_time(start_time)}/#{format_time(end_time)}.json")
      else
        get("user/-/activities/heart/date/#{format_date(date)}/1d/#{detail_level}.json")
      end
    end
  end
end

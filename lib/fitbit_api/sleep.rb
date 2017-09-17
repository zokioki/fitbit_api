module FitbitAPI
  class Client
    SLEEP_RESOURCES = %w(startTime timeInBed minutesAsleep awakeningsCount
                         minutesAwake minutesToFallAsleep minutesAfterWakeup efficiency)

    def sleep_logs(date=Date.today, opts={})
      get("user/#{user_id}/sleep/date/#{format_date(date)}.json", opts)
    end

    def sleep_time_series(resource, opts={})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      unless SLEEP_RESOURCES.include?(resource)
        raise FitbitAPI::InvalidArgumentError, "Invalid resource: \"#{resource}\". Please provide one of the following: #{SLEEP_RESOURCES}."
      end

      if [period, start_date].none?
        raise FitbitAPI::InvalidArgumentError, 'A start_date or period is required.'
      end

      if period && !PERIODS.include?(period)
        raise FitbitAPI::InvalidArgumentError, "Invalid period: \"#{period}\". Please provide one of the following: #{PERIODS}."
      end

      if period
        result = get("user/#{user_id}/activities/#{resource}/date/#{format_date(end_date)}/#{period}.json", opts)
      else
        result = get("user/#{user_id}/activities/#{resource}/date/#{format_date(start_date)}/#{format_date(end_date)}.json", opts)
      end
      # remove root key from response
      result.values[0]
    end
  end
end

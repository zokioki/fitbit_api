module Fitbyte
  class Client
    SLEEP_PERIODS = %w(1d 7d 30d 1w 1m 3m 6m 1y max)
    SLEEP_RESOURCES = %w(startTime timeInBed minutesAsleep awakeningsCount
                         minutesAwake minutesToFallAsleep minutesAfterWakeup efficiency)

    def sleep_logs(date=Date.today, opts={})
      get("user/#{@user_id}/sleep/date/#{format_date(date)}.json", opts)
    end

    def sleep_time_series(resource, opts={})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      unless SLEEP_RESOURCES.include?(resource)
        raise Fitbyte::InvalidArgumentError, "Invalid resource: \"#{resource}\". Please provide one of the following: #{SLEEP_RESOURCES}."
      end

      if [period, start_date].none?
        raise Fitbyte::InvalidArgumentError, "A start_date or period is required."
      end

      if period && !SLEEP_PERIODS.include?(period)
        raise Fitbyte::InvalidArgumentError, "Invalid period: \"#{period}\". Please provide one of the following: #{SLEEP_PERIODS}."
      end

      if period
        result = get("user/#{@user_id}/activities/#{resource}/date/#{format_date(end_date)}/#{period}.json", opts)
      else
        result = get("user/#{@user_id}/activities/#{resource}/date/#{format_date(start_date)}/#{format_date(end_date)}.json", opts)
      end
      # remove root key from response
      result.values[0]
    end
  end
end

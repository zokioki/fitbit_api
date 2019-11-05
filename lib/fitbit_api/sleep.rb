module FitbitAPI
  class Client
    SLEEP_RESOURCES = %w(startTime timeInBed minutesAsleep awakeningsCount
                         minutesAwake minutesToFallAsleep minutesAfterWakeup efficiency)

    def sleep_logs(date=Date.today, opts={})
      get("user/#{user_id}/sleep/date/#{format_date(date)}.json", opts)
    end

    def sleep_time_series(opts={})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today

      if [start_date].none?
        raise FitbitAPI::InvalidArgumentError, 'A start_date is required.'
      end

      result = get("user/#{user_id}/sleep/date/#{format_date(start_date)}/#{format_date(end_date)}.json", opts)
      # remove root key from response
      result.values[0]
    end
  end
end

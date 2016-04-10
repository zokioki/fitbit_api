module Fitbyte
  class Client
    BODY_PERIODS = %w(1d 7d 30d 1w 1m 3m 6m 1y max)
    BODY_RESOURCES = %w(bmi fat weight)

    def weight_logs(date=Date.today, opts={})
      get("user/-/body/log/weight/date/#{format_date(date)}.json", opts)
    end

    def body_fat_logs(date=Date.today, opts={})
      get("user/-/body/log/fat/date/#{format_date(date)}.json", opts)
    end

    def weight_goals(opts={})
      get("user/-/body/log/weight/goal.json", opts)
    end

    def body_fat_goals(opts={})
      get("user/-/body/log/fat/goal.json", opts)
    end

    def body_time_series(resource, opts={})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      unless BODY_RESOURCES.include?(resource)
        raise Fitbyte::InvalidArgumentError, "Invalid resource: \"#{resource}\". Please provide one of the following: #{BODY_RESOURCES}."
      end

      if [period, start_date].none?
        raise Fitbyte::InvalidArgumentError, "A start_date or period is required."
      end

      if period && !BODY_PERIODS.include?(period)
        raise Fitbyte::InvalidArgumentError, "Invalid period: \"#{period}\". Please provide one of the following: #{BODY_PERIODS}."
      end

      if period
        result = get("user/#{@user_id}/body/#{resource}/date/#{format_date(end_date)}/#{period}.json", opts)
      else
        result = get("user/#{@user_id}/body/#{resource}/date/#{format_date(start_date)}/#{format_date(end_date)}.json", opts)
      end
      # remove root key from response
      result.values[0]
    end
  end
end

# frozen_string_literal: true

module FitbitAPI
  class Client
    def heart_rate_time_series(opts = {})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      raise FitbitAPI::InvalidArgumentError, 'A start_date or period is required.' if [period, start_date].none?

      if period && !PERIODS.include?(period)
        raise FitbitAPI::InvalidArgumentError,
              "Invalid period: \"#{period}\". Please provide one of the following: #{PERIODS}."
      end

      result = if period
                 get("user/#{user_id}/activities/heart/date/#{format_date(end_date)}/#{period}.json")
               else
                 get("user/#{user_id}/activities/heart/date/#{format_date(start_date)}/#{format_date(end_date)}.json")
               end

      strip_root_key(result)
    end

    def heart_rate_intraday_time_series(opts = {})
      date         = opts[:date] || Date.today
      detail_level = opts[:detail_level]
      start_time   = opts[:start_time]
      end_time     = opts[:end_time]

      if [date, detail_level].any?(&:nil?)
        raise FitbitAPI::InvalidArgumentError, 'A date and detail_level are required.'
      end

      unless %(1sec 1min).include? detail_level
        raise FitbitAPI::InvalidArgumentError,
              "Invalid detail_level: \"#{detail_level}\". Please provide one of the following: \"1sec\" or \"1min\"."
      end

      if (start_time || end_time) && !(start_time && end_time)
        raise FitbitAPI::InvalidArgumentError, 'Both start_time and end_time are required if time is being specified.'
      end

      path = "user/#{user_id}/activities/heart/date/#{format_date(date)}/1d/#{detail_level}"
      path += "/time/#{format_time(start_time)}/#{format_time(end_time)}" if start_time && end_time

      get("#{path}.json")
    end
  end
end

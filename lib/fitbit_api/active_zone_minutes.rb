# frozen_string_literal: true

module FitbitAPI
  class Client
    # Returns the daily summary Active Zone Minutes (AZM) values over a specified date range or period.
    #
    #   active_zone_minutes_time_series(start_date: Date.parse('2021-04-16'), period: '7d')
    #   active_zone_minutes_time_series(start_date: Date.parse('2021-05-18'), end_date: Date.parse('2021-05-24'))
    #
    # @param opts [Hash] The request parameters
    #
    # @option opts :start_date [Date] The start of the date range
    # @option opts :end_date [Date] The end of the date range
    # @option opts :period [String] The range for which data will be returned

    def active_zone_minutes_time_series(opts = {})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      raise FitbitAPI::InvalidArgumentError, 'A start_date or period is required.' if [period, start_date].none?

      if period && !PERIODS.include?(period)
        raise FitbitAPI::InvalidArgumentError,
              "Invalid period: \"#{period}\". Please provide one of the following: #{PERIODS}."
      end

      result = if period
                 get("user/#{user_id}/activities/active-zone-minutes/date/#{format_date(end_date)}/#{period}.json")
               else
                 get("user/#{user_id}/activities/active-zone-minutes/date/#{format_date(start_date)}/#{format_date(end_date)}.json")
               end

      strip_root_key(result)
    end

    # Retrieves the Active Zone Minutes (AZM) intraday time series data for a specific date or 24 hour period.
    #
    # @param opts [Hash] The request parameters
    #
    # @option opts :date [Date] The date for which to retrieve the data
    # @option opts :detail_level [String] Number of data poins to include
    # @option opts :start_time [String] The time in the format HH:mm
    # @option opts :end_time [String] The time in the format HH:mm

    def active_zone_minutes_intraday_time_series(opts = {})
      date         = opts[:date] || Date.today
      detail_level = opts[:detail_level]
      start_time   = opts[:start_time]
      end_time     = opts[:end_time]

      if [date, detail_level].any?(&:nil?)
        raise FitbitAPI::InvalidArgumentError, 'A date and detail_level are required.'
      end

      unless %(1min 5min 15min).include? detail_level
        raise FitbitAPI::InvalidArgumentError,
              "Invalid detail_level: \"#{detail_level}\". Please provide one of the following: \"1min\", \"5min\" or \"15min\"."
      end

      if (start_time || end_time) && !(start_time && end_time)
        raise FitbitAPI::InvalidArgumentError, 'Both start_time and end_time are required if time is being specified.'
      end

      path = "user/#{user_id}/activities/active-zone-minutes/date/#{format_date(date)}/1d/#{detail_level}"
      path += "/time/#{format_time(start_time)}/#{format_time(end_time)}" if start_time && end_time

      get("#{path}.json")
    end
  end
end

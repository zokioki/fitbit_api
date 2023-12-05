# frozen_string_literal: true

module FitbitAPI
  class Client
    SLEEP_RESOURCES = %w[startTime timeInBed minutesAsleep awakeningsCount
                         minutesAwake minutesToFallAsleep minutesAfterWakeup efficiency].freeze

    # Returns a list of a user's sleep log entries for a given date. The data returned can include sleep
    # periods that began on the previous date. For example, if you request a Sleep Log for 2021-12-22,
    # it may return a log entry that began the previous night on 2021-12-21, but ended on 2021-12-22.
    #
    # @param date [Date, String] The date for the sleep log to be returned in the format yyyy-MM-dd

    def sleep_logs(date = Date.today)
      get("user/#{user_id}/sleep/date/#{format_date(date)}.json")
    end

    # Returns a list of a user's sleep log entries before or after a given date, and specifying offset,
    # limit and sort order. The data returned for different dates can include sleep periods that began
    # on the previous date. For example, a sleep log entry for 2018-10-21 may have ended that day but
    # started the previous night on 2018-10-20.
    #
    #   sleep_logs_list(before_date: Date.parse('2021-05-24'), limit: 5)
    #
    # @param params [Hash] The request parameters
    #
    # @option params :before_date [Date] Specify when filtering entries that occured before the given date
    # @option params :after_date [Date] Specify when filtering entries that occured after the given date
    # @option params :sort [String] the Sort order of entries by date (asc or desc)
    # @option params :offset [Integer] The offset number of entries. Must always be 0
    # @option params :limit [Integer] The max of the number of entries returned (max: 100)

    def sleep_logs_list(params = {})
      default_params = { before_date: Date.today, after_date: nil, sort: 'desc', limit: 20, offset: 0 }
      get("user/#{user_id}/sleep/list.json", default_params.merge(params))
    end

    # Creates a log entry for a sleep event

    def create_sleep_log(body)
      post("user/#{user_id}/sleep.json", body)
    end

    # Deletes a sleep log with the given log ID
    def delete_sleep_log(sleep_log_id)
      delete("user/#{user_id}/sleep/#{sleep_log_id}.json")
    end

    def sleep_time_series(resource, opts = {})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      unless SLEEP_RESOURCES.include?(resource)
        raise FitbitAPI::InvalidArgumentError,
              "Invalid resource: \"#{resource}\". Please provide one of the following: #{SLEEP_RESOURCES}."
      end

      raise FitbitAPI::InvalidArgumentError, 'A start_date or period is required.' if [period, start_date].none?

      if period && !PERIODS.include?(period)
        raise FitbitAPI::InvalidArgumentError,
              "Invalid period: \"#{period}\". Please provide one of the following: #{PERIODS}."
      end

      result = if period
                 get("user/#{user_id}/sleep/#{resource}/date/#{format_date(end_date)}/#{period}.json")
               else
                 get("user/#{user_id}/sleep/#{resource}/date/#{format_date(start_date)}/#{format_date(end_date)}.json")
               end

      strip_root_key(result)
    end

    def sleep_logs_by_date_range(opts = {})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      raise FitbitAPI::InvalidArgumentError, 'A start_date or period is required.' if [period, start_date].none?

      if period && !PERIODS.include?(period)
        raise FitbitAPI::InvalidArgumentError,
              "Invalid period: \"#{period}\". Please provide one of the following: #{PERIODS}."
      end

      result = if period
                 get("user/#{user_id}/sleep/date/#{format_date(end_date)}/#{period}.json")
               else
                 get("user/#{user_id}/sleep/date/#{format_date(start_date)}/#{format_date(end_date)}.json")
               end

      strip_root_key(result)
    end
  end
end

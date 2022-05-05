module FitbitAPI
  class Client

    ACTIVITY_RESOURCES = %w(calories caloriesBMR steps distance floors elevation
                            minutesSedentary minutesLightlyActive minutesFairlyActive
                            minutesVeryActive activityCalories tracker/calories
                            tracker/steps tracker/distance tracker/floors
                            tracker/elevation tracker/minutesSedentary
                            tracker/minutesLightlyActive tracker/minutesFairlyActive
                            tracker/minutesVeryActive tracker/activityCalories)

    ACTIVITY_INTRADAY_RESOURCES = %w(calories steps distance floors elevation)

    # GET Activities
    # ==============

    # Retrieves a summary and list of a user's activities and activity log entries
    # for a given day in the format requested using units in the unit system which
    # corresponds to the Accept-Language header provided.
    #
    # @param date [Date] The date for which to retrieve the activity data.

    def daily_activity_summary(date=Date.today, opts={})
      get("user/#{user_id}/activities/date/#{format_date(date)}.json", opts)
    end

    # Retrieves a list of a user's frequent activities in the format requested using
    # units in the unit system which corresponds to the Accept-Language header provided.

    def frequent_activities(opts={})
      get("user/#{user_id}/activities/frequent.json", opts)
    end

    def recent_activities(opts={})
      get("user/#{user_id}/activities/recent.json", opts)
    end

    # Returns a list of a user's favorite activities.

    def favorite_activities(opts={})
      get("user/#{user_id}/activities/favorite.json", opts)
    end

    # Gets a tree of all valid Fitbit public activities from the activities catalog
    # as well as private custom activities the user created.

    def all_activities(opts={})
      get('activities.json', opts)
    end

    # Retrieves a list of a user's activity log entries before or after a given day
    # with offset and limit using units in the unit system which corresponds to the
    # Accept-Language header provided.
    #
    #   activity_logs_list(before_date: Date.parse('2021-05-24'), limit: 5)
    #
    # @option before_date [Date] Specify when filtering entries that occured before the given date
    # @option after_date [Date] Specify when filtering entries that occured after the given date
    # @option sort [String] the Sort order of entries by date (asc or desc)
    # @option offset [Integer] The offset number of entries. Must always be 0
    # @option limit [Integer] The max of the number of entries returned (max: 20)

    def activity_logs_list(opts={})
      opts[:params] = {}
      param_defaults = { before_date: Date.today, after_date: nil, sort: 'desc', limit: 20, offset: 0 }

      # move param values from top-level opts into :params sub-hash
      param_defaults.each do |key, default_val|
        opts[:params][key] = opts.delete(key) || default_val
      end

      get("user/#{user_id}/activities/list.json", opts)
    end

    # Returns the details of a specific activity in the Fitbit activities database in the format requested.
    # If activity has levels, also returns a list of activity level details.
    #
    # @param activity_id [Integer, String] The ID of the desired activity to retrieve

    def activity(activity_id)
      get("activities/#{activity_id}.json")
    end

    # Retrieves the user's activity statistics in the format requested using units
    # in the unit system which corresponds to the Accept-Language header provided.
    # Activity statistics includes Lifetime and Best achievement values from the
    # My Achievements tile on the website dashboard.

    def lifetime_stats(opts={})
      get("user/#{user_id}/activities.json", opts)
    end

    def activity_time_series(resource, opts={})
      start_date = opts[:start_date]
      end_date   = opts[:end_date] || Date.today
      period     = opts[:period]

      unless ACTIVITY_RESOURCES.include?(resource)
        raise FitbitAPI::InvalidArgumentError, "Invalid resource: \"#{resource}\". Please provide one of the following: #{ACTIVITY_RESOURCES}."
      end

      if [start_date, period].none?
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

    def activity_intraday_time_series(resource, opts={})
      date         = opts[:date] || Date.today
      detail_level = opts[:detail_level]
      start_time   = opts[:start_time]
      end_time     = opts[:end_time]

      unless ACTIVITY_INTRADAY_RESOURCES.include?(resource)
        raise FitbitAPI::InvalidArgumentError, "Invalid resource: \"#{resource}\". Please provide one of the following: #{ACTIVITY_RESOURCES}."
      end

      if [date, detail_level].any?(&:nil?)
        raise FitbitAPI::InvalidArgumentError, 'A date and detail_level are required.'
      end

      unless %(1min 15min).include? detail_level
        raise FitbitAPI::InvalidArgumentError, "Invalid detail_level: \"#{detail_level}\". Please provide one of the following: \"1min\" or \"15min\"."
      end

      if (start_time || end_time) && !(start_time && end_time)
        raise FitbitAPI::InvalidArgumentError, 'Both start_time and end_time are required if time is being specified.'
      end

      if (start_time && end_time)
        get("user/-/activities/#{resource}/date/#{format_date(date)}/1d/#{detail_level}/time/#{format_time(start_time)}/#{format_time(end_time)}.json")
      else
        get("user/-/activities/#{resource}/date/#{format_date(date)}/1d/#{detail_level}.json")
      end
    end

    # POST Activities
    # ===============

    # Creates log entry for an activity or user's private custom activity using units
    # in the unit system which corresponds to the Accept-Language header provided.
    #
    #   log_activity(body: { activity_id: 90013, manual_calories: 300, duration_millis: 6000000 })
    #
    # @option activity_id [Integer, String] The activity ID
    # @option activity_name [String] Custom activity name. Either activity ID or activity_name must be provided
    # @option manual_calories [Integer] Calories burned, specified manually. Required with activity_name, otherwise optional
    # @option start_time [String] Activity start time; formatted in HH:mm:ss
    # @option duration_millis [Integer] Duration in milliseconds
    # @option date [String] Log entry date; formatted in yyyy-MM-dd
    # @option distance [Integer] Distance; required for logging directory activity
    # @option distance_unit [String] Distance measurement unit

    def log_activity(opts)
      post("user/#{user_id}/activities.json", opts)
    end

    # Adds the activity with the given ID to user's list of favorite activities.
    #
    # @param activity_id [Integer] The activity ID

    def add_favorite_activity(activity_id)
      post("user/#{user_id}/activities/favorite/#{activity_id}.json")
    end

    # DELETE Activities
    # =================

    # Deletes a user's activity log entry with the given ID.
    #
    # @param activity_log_id [Integer] The ID of the activity log entry

    def delete_activity(activity_log_id)
      delete("user/#{user_id}/activities/#{activity_log_id}.json")
    end

    # Removes the activity with the given ID from a user's list of favorite activities.
    #
    # @param activity_id [Integer] The ID of the activity to be removed

    def delete_favorite_activity(activity_id)
      delete("user/#{user_id}/activities/favorite/#{activity_id}.json")
    end
  end
end

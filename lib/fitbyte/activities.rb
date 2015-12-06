module Fitbyte
  class Client
    # GET Activities
    # ==============

    # Retrieves a summary and list of a user's activities and activity log entries for a given day
    #   in the format requested using units in the unit system which corresponds to the Accept-Language header provided.

    def daily_activity_summary(date=Date.today, opts={})
      get("user/#{@user_id}/activities/date/#{format_date(date)}.json", opts)
    end

    # Retrieves a list of a user's frequent activities in the format requested using units
    #   in the unit system which corresponds to the Accept-Language header provided.

    def frequent_activities(opts={})
      get("user/#{@user_id}/activities/frequent.json", opts)
    end

    def recent_activities(opts={})
      get("user/#{@user_id}/activities/recent.json", opts)
    end

    # Returns a list of a user's favorite activities.

    def favorite_activities(opts={})
      get("user/#{@user_id}/activities/favorite.json", opts)
    end

    # Gets a tree of all valid Fitbit public activities from
    #   the activities catalog as well as private custom activities the user created.

    def all_activities(opts={})
      get("activities.json", opts)
    end

    # Retrieves a list of a user's activity log entries before or after a given day with
    #   offset and limit using units in the unit system which corresponds to the Accept-Language header provided.

    # ==== Parameters
    # * +:beforeDate+ - the date; formatted in yyyy-MM-ddTHH:mm:ss
    # * +:afterDate+ - the date; formatted in yyyy-MM-ddTHH:mm:ss
    # * +:sort+ - the sort order of entries by date (asc or desc)
    # * +:offset+ - the offset number of entries
    # * +:limit+ - the max of the number of entries returned (max: 100)

    def activity_logs_list(opts={})
      get("user/#{@user_id}/activities/list.json", opts)
    end

    # Returns the details of a specific activity in the Fitbit activities database in the format requested.
    #   If activity has levels, also returns a list of activity level details.

    def activity(activity_id)
      get("activities/#{activity_id}.json")
    end

    # Retrieves the user's activity statistics in the format requested using units
    #   in the unit system which corresponds to the Accept-Language header provided.
    #   Activity statistics includes Lifetime and Best achievement values from the
    #   My Achievements tile on the website dashboard.

    def lifetime_stats(opts={})
      get("user/#{@user_id}/activities.json", opts)
    end

    # Retrieves a user's current daily activity goals.

    def daily_goals(opts={})
      get("user/#{@user_id}/activities/goals/daily.json", opts)
    end

    # Retrieves a user's current weekly activity goals.

    def weekly_goals(opts={})
      get("user/#{@user_id}/activities/goals/weekly.json", opts)
    end

    # POST Activities
    # ===============

    # Creates log entry for an activity or user's private custom activity using units
    #   in the unit system which corresponds to the Accept-Language header provided.

    # ==== POST Parameters
    # * +:activityId+ - activity id
    # * +:activityName+ - custom activity name. Either activity ID or activityName must be provided
    # * +:manualCalories+ - calories burned, specified manually. Required with activityName, otherwise optional
    # * +:startTime+ - activity start time; formatted in HH:mm:ss
    # * +:durationMillis+ - duration in milliseconds
    # * +:date+ - log entry date; formatted in yyyy-MM-dd
    # * +:distance+ - distance; required for logging directory activity; formatted in X.XX
    # * +:distanceUnit+ - distance measurement unit

    def log_activity(opts)
      post("user/#{@user_id}/activities.json", opts)
    end

    # Adds the activity with the given ID to user's list of favorite activities.

    def add_favorite_activity(activity_id)
      post("user/#{@user_id}/activities/favorite/#{activity_id}.json")
    end

    # Creates or updates a user's daily activity goals and returns a response using units
    #   in the unit system which corresponds to the Accept-Language header provided.

    # ==== POST Parameters
    # * +:caloriesOut+ - calories output goal value; integer
    # * +:activeMinutes+ - active minutes goal value; integer
    # * +:floors+ - floor goal value; integer
    # * +:distance+ - distance goal value; X.XX or integer
    # * +:steps+ - steps goal value; integer

    def create_or_update_daily_goals(opts={})
      post("user/#{@user_id}/activities/goals/daily.json", opts)
    end

    # Creates or updates a user's weekly activity goals and returns a response using units
    #   in the unit system which corresponds to the Accept-Language header provided.

    # ==== POST Parameters
    # * +:caloriesOut+ - calories output goal value; integer
    # * +:activeMinutes+ - active minutes goal value; integer
    # * +:floors+ - floor goal value; integer
    # * +:distance+ - distance goal value; X.XX or integer
    # * +:steps+ - steps goal value; integer

    def create_or_update_weekly_goals(opts={})
      post("user/#{@user_id}/activities/goals/weekly.json", opts)
    end

    # DELETE Activities
    # =================

    # Deletes a user's activity log entry with the given ID.

    def delete_activity(activity_log_id)
      delete("user/#{@user_id}/activities/#{activity_log_id}.json")
    end

    # Removes the activity with the given ID from a user's list of favorite activities.

    def delete_favorite_activity(activity_id)
      delete("user/#{@user_id}/activities/favorite/#{activity_id}.json")
    end
  end
end

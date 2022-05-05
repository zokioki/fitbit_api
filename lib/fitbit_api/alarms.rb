module FitbitAPI
  class Client
    # GET Alarms
    # ==========

    # Returns a list of the set alarms connected to a user's account.
    #
    # @params tracker_id [Integer] The ID of the tracker for which the data is returned

    def alarms(tracker_id, opts={})
      get("user/#{user_id}/devices/tracker/#{tracker_id}/alarms.json", opts)
    end

    # POST Alarms
    # ===========

    # Adds the alarm settings to a given ID for a given device.
    #
    #   add_alarm(body: { time: "07:15-08:00", enabled: true, recurring: true, week_days: "MONDAY,FRIDAY,SATURDAY" })
    #
    # @param tracker_id [Integer] The ID of the tracker for which the alarm is created
    #
    # @option time [String] Time of day that the alarm vibrates with a UTC timezone offset, e.g. 07:15-08:00
    # @option enabled [Boolean] If false, alarm does not vibrate until enabled is set to true
    # @option recurring [Boolean] If false, the alarm is a single event
    # @option week_days [String] Comma separated list of days of the week on which the alarm vibrates (MONDAY,TUESDAY)

    def add_alarm(tracker_id, opts={})
      post("user/#{user_id}/devices/tracker/#{tracker_id}/alarms.json", opts)
    end

    # Updates the alarm entry with a given ID for a given device.
    #
    # @param tracker_id [Integer] The ID of the tracker for which the alarm is created
    # @param alarm_id [Integer] The ID of the alarm to be updated
    #
    # @option time [String] Time of day that the alarm vibrates with a UTC timezone offset, e.g. 07:15-08:00
    # @option enabled [Boolean] If false, alarm does not vibrate until enabled is set to true
    # @option recurring [Boolean] If false, the alarm is a single event
    # @option week_days [String] Comma separated list of days of the week on which the alarm vibrates (MONDAY,TUESDAY)
    # @option snooze_length [Integer] Minutes between alarms
    # @option snooze_count [Integer] Maximum snooze count
    # @option label [String] Label for alarm
    # @option vibe [String] Vibe pattern; only one value for now (DEFAULT)

    def update_alarm(tracker_id, alarm_id, opts={})
      post("user/#{user_id}/devices/tracker/#{tracker_id}/alarms/#{alarm_id}.json", opts)
    end

    # DELETE Alarms
    # =============

    # Deletes the user's device alarm entry with the given ID for a given device.
    #
    # @param tracker_id [Integer] The ID of the tracker for which the alarm is to be deleted
    # @param alarm_id [Integer] The ID of the alarm to be deleted

    def delete_alarm(tracker_id, alarm_id, opts={})
      delete("user/#{user_id}/devices/tracker/#{tracker_id}/alarms/#{alarm_id}.json", opts)
    end
  end
end

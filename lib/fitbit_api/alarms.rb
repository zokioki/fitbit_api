# frozen_string_literal: true

module FitbitAPI
  class Client
    # Returns a list of the set alarms connected to a user's account.
    #
    # @param tracker_id [Integer] The ID of the tracker for which the data is returned

    def alarms(tracker_id)
      get("user/#{user_id}/devices/tracker/#{tracker_id}/alarms.json")
    end

    # Adds the alarm settings to a given ID for a given device.
    #
    #   add_alarm(123, time: "07:15-08:00", recurring: true, week_days: "MONDAY,FRIDAY,SATURDAY")
    #
    # @param tracker_id [Integer] The ID of the tracker for which the alarm is created
    # @param body [Hash] The POST request body
    #
    # @option body :time [String] Time of day that the alarm vibrates with a UTC timezone offset, e.g. 07:15-08:00
    # @option body :enabled [Boolean] If false, alarm does not vibrate until enabled is set to true
    # @option body :recurring [Boolean] If false, the alarm is a single event
    # @option body :week_days [String] Comma separated list of days of the week on which the alarm vibrates (MONDAY,TUESDAY)

    def add_alarm(tracker_id, body = {})
      post("user/#{user_id}/devices/tracker/#{tracker_id}/alarms.json", body)
    end

    # Updates the alarm entry with a given ID for a given device.
    #
    #   update_alarm(123, 987, week_days: "TUESDAY,SUNDAY")
    #
    # @param tracker_id [Integer] The ID of the tracker for which the alarm is created
    # @param alarm_id [Integer] The ID of the alarm to be updated
    # @param body [Hash] The POST request body.
    #
    # @option body :time [String] Time of day that the alarm vibrates with a UTC timezone offset, e.g. 07:15-08:00
    # @option body :enabled [Boolean] If false, alarm does not vibrate until enabled is set to true
    # @option body :recurring [Boolean] If false, the alarm is a single event
    # @option body :week_days [String] Comma separated list of days of the week on which the alarm vibrates (MONDAY,TUESDAY)
    # @option body :snooze_length [Integer] Minutes between alarms
    # @option body :snooze_count [Integer] Maximum snooze count
    # @option body :label [String] Label for alarm
    # @option body :vibe [String] Vibe pattern; only one value for now (DEFAULT)

    def update_alarm(tracker_id, alarm_id, body = {})
      post("user/#{user_id}/devices/tracker/#{tracker_id}/alarms/#{alarm_id}.json", body)
    end

    # Deletes the user's device alarm entry with the given ID for a given device.
    #
    #   delete_alarm(123, 987)
    #
    # @param tracker_id [Integer] The ID of the tracker for which the alarm is to be deleted
    # @param alarm_id [Integer] The ID of the alarm to be deleted

    def delete_alarm(tracker_id, alarm_id)
      delete("user/#{user_id}/devices/tracker/#{tracker_id}/alarms/#{alarm_id}.json")
    end
  end
end

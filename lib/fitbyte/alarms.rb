module FitbitAPI
  class Client
    # GET Alarms
    # ==========

    # Returns a list of the set alarms connected to a user's account.

    def alarms(tracker_id, opts={})
      get("user/#{user_id}/devices/tracker/#{tracker_id}/alarms.json", opts)
    end

    # POST Alarms
    # ===========

    # Adds the alarm settings to a given ID for a given device.

    # ==== POST Parameters
    # * +:time+ - time of day that the alarm vibrates with a UTC timezone offset, e.g. 07:15-08:00
    # * +:enabled+ - boolean; if false, alarm does not vibrate until enabled is set to true
    # * +:recurring+ - boolean; if false, the alarm is a single event
    # * +:weekDays+ - comma separated list of days of the week on which the alarm vibrates (MONDAY,TUESDAY)

    def add_alarm(tracker_id, opts={})
      post("user/#{user_id}/devices/tracker/#{tracker_id}/alarms.json", opts)
    end

    # Updates the alarm entry with a given ID for a given device.

    # ==== POST Parameters
    # * +:time+ - time of day that the alarm vibrates with a UTC timezone offset, e.g. 07:15-08:00
    # * +:enabled+ - boolean; if false, alarm does not vibrate until enabled is set to true
    # * +:recurring+ - boolean; if false, the alarm is a single event
    # * +:weekDays+ - comma separated list of days of the week on which the alarm vibrates (MONDAY,TUESDAY)
    # * +:snoozeLength+ - integer; minutes between alarms
    # * +:snoozeCount+ - integer; maximum snooze count
    # * +:label+ - string; label for alarm
    # * +:vibe+ - vibe pattern; only one value for now (DEFAULT)

    def update_alarm(tracker_id, alarm_id, opts={})
      post("user/#{user_id}/devices/tracker/#{tracker_id}/alarms/#{alarm_id}.json", opts)
    end

    # DELETE Alarms
    # =============

    # Deletes the user's device alarm entry with the given ID for a given device.

    def delete_alarm(tracker_id, alarm_id, opts={})
      delete("user/#{user_id}/devices/tracker/#{tracker_id}/alarms/#{alarm_id}.json", opts)
    end
  end
end

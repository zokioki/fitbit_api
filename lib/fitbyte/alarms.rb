module Fitbyte
  class Client
    def alarms(tracker_id)
      get("1/user/-/devices/tracker/#{tracker_id}/alarms.json")
    end
  end
end

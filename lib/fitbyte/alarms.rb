module Fitbyte
  class Client
    def alarms(tracker_id, opts={})
      get("user/#{@user_id}/devices/tracker/#{tracker_id}/alarms.json", opts)
    end
  end
end

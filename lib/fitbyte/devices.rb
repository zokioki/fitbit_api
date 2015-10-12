module Fitbyte
  class Client
    def devices
      get("user/#{@user_id}/devices.json")
    end
  end
end

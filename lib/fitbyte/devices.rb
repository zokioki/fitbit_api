module Fitbyte
  class Client
    def devices
      get("user/-/devices.json")
    end
  end
end

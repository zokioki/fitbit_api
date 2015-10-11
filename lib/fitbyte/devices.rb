module Fitbyte
  class Client
    def devices
      get("1/user/-/devices.json")
    end
  end
end

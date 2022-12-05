# frozen_string_literal: true

module FitbitAPI
  module Configuration
    def configure
      yield self
    end

    def define_setting(name, default = nil)
      instance_variable_set("@#{name}", default)

      define_singleton_method("#{name}=") do |value|
        instance_variable_set("@#{name}", value)
      end

      define_singleton_method(name) do
        instance_variable_get("@#{name}")
      end
    end
  end
end

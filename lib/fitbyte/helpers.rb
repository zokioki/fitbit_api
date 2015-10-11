module Fitbyte
  class Client
    def format_date(date)
      if [Date, Time, DateTime].include?(date.class)
        date.strftime("%Y-%m-%d")
      elsif date.is_a? String
        if date =~ /\d{4}\-\d{2}\-\d{2}/
          date
        else
          raise ArgumentError, "Invalid argument [\"#{date}\"] - string must follow yyyy-MM-dd format."
        end
      else
        raise ArgumentError, "Invalid type [#{date.class}] - provide a Date/Time/DateTime or a String(yyyy-MM-dd format)."
      end
    end

    def format_scope(scope)
      scope.is_a?(Array) ? scope.join(" ") : scope
    end
  end
end

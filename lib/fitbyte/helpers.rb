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

    # Borrowing from Rails

    def deep_keys_to_snake_case!(object)
      deep_transform_keys!(object) { |key| snake_case(key) }
    end

    def deep_symbolize_keys!(object)
      deep_transform_keys!(object) { |key| key.to_sym rescue key }
    end

    def deep_transform_keys!(object, &block)
      case object
      when Hash
        object.keys.each do |key|
          value = object.delete(key)
          object[yield(key)] = deep_transform_keys!(value) { |key| yield(key) }
        end
        object
      when Array
        object.map! { |e| deep_transform_keys!(e) }
      else
        object
      end
    end

    def snake_case(word)
      word = word.dup.to_s
      return word.downcase if word.match(/\A[A-Z]+\z/)
      word.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      word.gsub!(/([a-z])([A-Z])/, '\1_\2')
      word.downcase
    end

  end
end

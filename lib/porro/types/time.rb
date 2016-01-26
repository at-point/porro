require 'time'

module Porro
  module Types
    class Time
      # 2012-04-23T18:25:43.511Z, http://stackoverflow.com/questions/10286204/the-right-json-date-format
      DATE_FORMAT = '%FT%T.%LZ'

      attr_reader :default_proc

      def initialize(default_proc = -> { ::Time.now })
        fail ArgumentError, "default_proc required" unless default_proc.respond_to?(:call)
        @default_proc = default_proc
      end

      def load(value)
        return value.to_time if value.respond_to?(:to_time)
        return ::Time.at(value.to_int) if value.respond_to?(:to_int)
        ::Time.parse(value.to_s)
      rescue TypeError, ArgumentError
        default_proc.call
      end

      def dump(attribute)
        return nil unless attribute.respond_to?(:to_time)
        attribute.to_time.utc.strftime(DATE_FORMAT)
      end
    end
  end
end

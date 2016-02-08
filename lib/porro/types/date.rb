require 'date'
require 'porro/types/base'

module Porro
  module Types
    class Date
      # 2012-04-23T18:25:43.511Z, http://stackoverflow.com/questions/10286204/the-right-json-date-format
      DATE_FORMAT = '%FT00:00:00.000Z'

      include Base

      attr_reader :default_proc

      def initialize(default_proc = -> { ::Date.today })
        fail ArgumentError, "default_proc required" unless default_proc.respond_to?(:call)
        @default_proc = default_proc
      end

      def load(value)
        return value.to_date if value.respond_to?(:to_date)
        ::Date.parse(value.to_s)
      rescue TypeError, ArgumentError
        default_proc.call
      end

      def dump(attribute)
        return nil unless attribute.respond_to?(:to_date)
        attribute.to_date.strftime(DATE_FORMAT)
      end
    end
  end
end

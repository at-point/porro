require 'date'
require 'porro/types/base'

module Porro
  def self.date
    Types::Date
  end

  module Types
    module Date
      # 2012-04-23T18:25:43.511Z, http://stackoverflow.com/questions/10286204/the-right-json-date-format
      DATE_FORMAT = '%FT00:00:00.000Z'

      extend Base

      def self.load(value)
        return value.to_date if value.respond_to?(:to_date)
        ::Date.parse(value.to_s)
      rescue TypeError, ArgumentError
        nil
      end

      def self.dump(attribute)
        return nil unless attribute.respond_to?(:to_date)
        attribute.to_date.strftime(DATE_FORMAT)
      end
    end
  end
end

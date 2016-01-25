module Porro
  module Types
    class Enum
      attr_reader :values, :default_value

      def initialize(values, default_value: nil)
        @values = values
        @default_value = default_value
      end

      def load(value)
        value = value.to_s
        values.find { |v| v.to_s == value } || default_value
      end
      alias_method :load, :dump
    end
  end
end

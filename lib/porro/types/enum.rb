module Porro
  module Types
    class Enum
      include Base
      attr_reader :values

      def initialize(values)
        @values = values
      end

      def load(value)
        value = value.to_s
        values.find { |v| v.to_s == value }
      end
      alias_method :dump, :load
    end
  end
end

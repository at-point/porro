module Porro
  module Types
    class Default
      include Base

      attr_reader :wrapped
      attr_reader :default

      def initialize(wrapped, default = nil)
        Types.typeish!(wrapped)
        @wrapped = wrapped
        @default = default
      end

      def load(value)
        @wrapped.load(value) || get_default
      end

      def dump(attribute)
        @wrapped.dump(attribute) || get_default
      end

      private

      def get_default
        default.respond_to?(:call) ? default.call : default
      end
    end
  end
end

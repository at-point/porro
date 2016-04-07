module Porro
  module Types
    class Default
      include Base

      attr_reader :wrapped
      attr_reader :default_proc

      def initialize(wrapped, default = nil)
        Types.typeish!(wrapped)
        @wrapped = wrapped
        @default_proc = default.respond_to?(:call) ? default : -> { default }
      end

      def load(value)
        @wrapped.load(value) || default_proc.call
      end

      def dump(attribute)
        @wrapped.dump(attribute) || default_proc.call
      end
    end
  end
end

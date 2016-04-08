module Porro
  module Types
    class Default
      include Base

      attr_reader :wrapper
      attr_reader :default_proc

      def initialize(wrapper, default = nil)
        Types.typeish!(wrapper)
        @wrapper = wrapper
        @default_proc = default.respond_to?(:call) ? default : -> { default }
      end

      def load(value)
        @wrapper.load(value) || default_proc.call
      end

      def dump(attribute)
        @wrapper.dump(attribute) || default_proc.call
      end
    end
  end
end

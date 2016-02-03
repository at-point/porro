module Porro
  module Types
    class Blankified
      attr_reader :wrapped

      def self.blank?(obj)
        obj.nil? ||
          (obj.respond_to?(:empty?) && obj.empty?) ||
          (obj.respond_to?(:to_str) && obj.to_str.strip.empty?)
      end

      def initialize(wrapped)
        Porro::Types.implements_interface!(wrapped)
        @wrapped = wrapped
      end

      def load(value)
        return nil if self.class.blank?(value)
        @wrapped.load(value)
      end

      def dump(attribute)
        return nil if self.class.blank?(attribute) # FIXME: how to handle e.g. empty Array?
        @wrapped.dump(attribute)
      end
    end
  end
end

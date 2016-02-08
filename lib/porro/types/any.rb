require 'porro/types/base'

module Porro
  def self.any
    Types::Any
  end

  def self.custom(type)
    Types::WrappedType.new(type)
  end

  module Types
    class WrappedType
      include Base

      attr_reader :type

      def initialize(type)
        @type = type
      end

      def load(value)
        type.load(value)
      end

      def dump(value)
        type.dump(value)
      end
    end

    # Represents *any* kind of value, even those that do not safely
    # encode / decode from JSON. This is similar to an Identity() function.
    module Any
      extend Types::Base

      def self.load(value)
        value
      end

      def self.dump(attribute)
        attribute
      end
    end
  end
end

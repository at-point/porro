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

      def to_ast
        if type.respond_to?(:to_ast)
          [:wrapped, type.to_ast]
        else
          [:wrapped, [:type, type.name]]
        end
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

      def self.to_ast
        [:type, 'any']
      end
    end
  end
end

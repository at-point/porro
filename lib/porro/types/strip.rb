module Porro
  module Types
    class Strip
      include Base

      attr_reader :wrapped

      def self.strip(value)
        return value.strip if value.respond_to?(:strip)
        return value.compact if value.respond_to?(:compact)
        value
      end

      def initialize(wrapped)
        Porro::Types.typeish!(wrapped)
        @wrapped = wrapped
      end

      def load(value)
        @wrapped.load self.class.strip(value)
      end

      def dump(value)
        @wrapped.dump self.class.strip(value)
      end

      def to_ast
        if wrapped.respond_to?(:to_ast)
          [:strip, wrapped.to_ast]
        else
          [:strip, [:type, wrapped.name]]
        end
      end
    end
  end
end

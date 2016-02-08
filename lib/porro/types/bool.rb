require 'porro/types/base'

module Porro
  def self.bool
    Types::Bool
  end

  module Types
    # Support for casting of boolean values.
    module Bool
      extend Base

      FALSEY = ['0', 'false', 'no', 'off']

      def self.falsey?(value)
        !value || FALSEY.include?(value.to_s.strip.downcase)
      end

      def self.load(value)
        return false if falsey?(value)
        true
      end

      def self.dump(attribute)
        !!attribute
      end
    end
  end
end

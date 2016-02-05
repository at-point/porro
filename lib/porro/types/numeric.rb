require 'porro/types/base'

module Porro
  def self.integer
    Types::Numeric
  end

  module Types
    module Numeric
      extend Base

      def self.load(value)
        return 0 unless value.respond_to?(:to_i)
        value.to_i
      end

      def self.dump(attribute)
        load(attribute)
      end
    end
  end
end

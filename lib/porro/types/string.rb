require 'porro/types/base'

module Porro
  def self.string
    Types::String
  end

  module Types
    module String
      extend Base

      def self.load(value)
        value.to_s
      end

      def self.dump(value)
        value.to_s
      end

      def self.to_ast
        [:type, 'string']
      end
    end
  end
end

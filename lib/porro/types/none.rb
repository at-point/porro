require 'porro/types/base'

module Porro
  module Types
    module None
      extend Base

      def self.load(value); nil end
      def self.dump(attribute); nil end
    end
  end
end

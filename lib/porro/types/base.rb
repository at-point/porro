module Porro
  module Types
    module Base
      def blankify
        Blankify.new(self)
      end

      def strip
        Strip.new(self)
      end

      def default(value)
        Default.new(self, value)
      end
    end
  end
end

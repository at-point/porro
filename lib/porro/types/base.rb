module Porro
  module Types
    module Base
      def blankify
        Blankify.new(self)
      end

      def strip
        Strip.new(self)
      end
    end
  end
end

module Porro
  module Types

    # Support for casting of boolean values.
    module Bool
      FALSEY = ['', '0', 'false']

      module_function

      def falsey?(value)
        !value || FALSEY.include?(value.to_s.strip.downcase)
      end

      def load(value)
        return false if falsey?(value)
        true
      end

      def dump(attribute)
        !!attribute
      end
    end
  end
end

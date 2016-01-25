module Porro
  module Types

    # Represents *any* kind of value, even those that do not safely
    # encode / decode from JSON. This is similar to an Identity() function.
    module Any
      module_function

      def load(value)
        value
      end

      def dump(attribute)
        attribute
      end
    end
  end
end

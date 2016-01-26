module Porro
  module Types
    module Numeric
      module_function

      def load(value)
        return 0 unless value.respond_to?(:to_i)
        value.to_i
      end

      def dump(attribute)
        load(attribute)
      end
    end
  end
end

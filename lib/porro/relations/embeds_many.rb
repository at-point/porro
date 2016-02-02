require 'porro/relations/embeds_one'

module Porro
  module Relations

    # Embedded / nested objects, they need to provide
    # an initializer which accepts all attributes.
    class EmbedsMany
      attr_reader :embedder

      def initialize(klass)
        @embedder = EmbedsOne.new(klass)
      end

      def load(ary)
        return [] unless ary.respond_to?(:map)
        ary.map { |attributes| embedder.load(attributes) }
      end

      def dump(ary)
        return [] unless ary.respond_to?(:map)
        ary.map { |object| embedder.dump(object) }
      end
    end
  end
end

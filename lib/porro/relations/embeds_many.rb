require 'porro/types'
require 'porro/relations/embeds_one'

module Porro
  module Relations

    # Embedded / nested objects, they need to provide
    # an initializer which accepts all attributes.
    class EmbedsMany
      attr_reader :type, :collection_klass

      def initialize(type, collection_klass = Array)
        @type = type
        @collection_klass = collection_klass
      end

      def load(ary)
        return collection_klass.new unless ary.respond_to?(:map)
        values = ary.map { |attributes| type.load(attributes) }
        collection_klass.new values.compact
      end

      def dump(ary)
        return [] unless ary.respond_to?(:to_a)
        ary.to_a.map { |object| type.dump(object) }
      end
    end
  end
end

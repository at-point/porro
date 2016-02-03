require 'porro/embeds/one'

module Porro
  module Embeds

    # Embedded / nested objects, they need to provide
    # an initializer which accepts all attributes.
    class Many
      attr_reader :type, :collection_klass

      def self.factory(type, collection = Array)
        new wrap_type(type), wrap_collection(collection)
      end

      def self.wrap_type(type)
        return Types.factory(type) if Types.supports?(type)
        One.new(type)
      end

      def self.wrap_collection(klass)
        return klass if klass.respond_to?(:new)
        return Array if klass == :array
        return Set if klass == :set
        fail ArgumentError, 'invalid collection class, only :array, :set allowed'
      end

      def initialize(type, collection_klass = Array)
        Types.implements_interface!(type)
        fail ArgumentError, 'collection_klass must implement .new' unless collection_klass.respond_to?(:new)

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

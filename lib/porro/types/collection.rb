require 'porro/types/object'

module Porro
  def self.collection(type, collection = Array)
    Types::Collection.new Types.factory(type), collection
  end

  def self.array(type)
    collection(type, Array)
  end

  def self.set(type)
    collection(type, Set)
  end

  module Types

    # Embedded / nested objects, they need to provide
    # an initializer which accepts all attributes.
    class Collection
      attr_reader :type, :collection_klass

      COLLECTIONS = {
        array: Array,
        set: Set
      }

      def self.wrap_collection(klass)
        return klass if klass.respond_to?(:new)
        return COLLECTIONS[klass] if COLLECTIONS.key?(klass)
        fail ArgumentError, 'invalid collection class, only :array, :set allowed'
      end

      def initialize(type, collection_klass = Array)
        Types.typeish!(type)

        @type = type
        @collection_klass = self.class.wrap_collection(collection_klass)
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

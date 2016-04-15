require 'set'
require 'porro/types/object'

module Porro
  def self.collection(type, collection = :array)
    Types::Collection.new Types.factory(type), collection
  end

  def self.array(type)
    collection(type, :array)
  end

  def self.set(type)
    collection(type, :set)
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
        return COLLECTIONS[klass] if COLLECTIONS.key?(klass)
        fail ArgumentError, 'invalid collection class, only :array, :set allowed'
      end

      def initialize(type, collection_klass = :array)
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

      def to_ast
        if type.respond_to?(:to_ast)
          [:collection, type.to_ast]
        else
          [:collection, [:type, type.name]]
        end
      end
    end
  end
end

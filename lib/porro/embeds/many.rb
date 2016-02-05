require 'porro/embeds/one'

module Porro
  def self.collection(type, collection = Array)
    type = Embeds::Many.wrap_type(type)
    collection = Embeds::Many.wrap_collection(collection)
    Embeds::Many.new type, collection
  end

  def self.array(type)
    collection(type, Array)
  end

  def self.set(type)
    collection(type, Set)
  end

  module Embeds

    # Embedded / nested objects, they need to provide
    # an initializer which accepts all attributes.
    class Many
      attr_reader :type, :collection_klass

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

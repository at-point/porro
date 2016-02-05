require 'porro/types/base'

module Porro
  def self.object(klass)
    Types::Object.new(klass)
  end

  module Types

    # Embedded / nested objects, they need to provide
    # an initializer which accepts all attributes.
    class Object
      include Types::Base

      attr_reader :klass

      def initialize(klass)
        fail ArgumentError, 'klass must implement #new' unless klass.respond_to?(:new)
        @klass = klass
      end

      def load(attributes)
        return attributes if attributes.is_a?(klass)
        klass.new(attributes)
      end

      def dump(object)
        return object.attributes if object.respond_to?(:attributes)
        return object.to_hash if object.respond_to?(:to_hash)
        return object.to_h if object.respond_to?(:to_h)
        warn "#{self.class} unable to dump object of type #{klass}: must implement #attributes, #to_hash or #to_h"
        {}
      end
    end
  end
end

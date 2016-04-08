require 'porro/types/any'
require 'porro/types/none'

require 'porro/types/bool'
require 'porro/types/date'
require 'porro/types/numeric'
require 'porro/types/string'

require 'porro/types/enum'
require 'porro/types/object'
require 'porro/types/collection'
require 'porro/types/email'

require 'porro/types/blankify'
require 'porro/types/strip'
require 'porro/types/default'

module Porro
  module Types
    TYPES = {
      bool: Porro::Types::Bool,
      date: Porro::Types::Date,
      integer: Porro::Types::Numeric,
      string: Porro::Types::String,
      any: Porro::Types::Any,
      none: Porro::Types::None
    }

    def self.factory(type, class_name: nil, blankify: false, strip: false)
      fail ArgumentError, 'type is required, was: nil' unless type
      return type if typeish?(type)

      type = object_factory(type) || collection_factory(type, class_name) || types_factory(type)
      type = type.blankify if blankify
      type = type.strip if strip
      type
    end

    def self.object_factory(type)
      Types::Object.new(type) if type.respond_to?(:new)
    end

    def self.collection_factory(type, class_name)
      if [:array, :set].include?(type) && class_name
        inner_type = object_factory(class_name) || types_factory(class_name)
        Porro::Types::Collection.new(inner_type, type == :set ? ::Set : ::Array)
      end
    end

    def self.types_factory(type)
      fail ArgumentError, "type must implement #load/#dump or be one of #{TYPES.keys.join(', ')}" unless TYPES.key?(type)
      TYPES[type]
    end

    def self.typeish?(type)
      %w{load dump}.all? { |method| type.respond_to?(method) }
    end

    def self.typeish!(type)
      fail ArgumentError, 'type must implement #load/#dump' unless typeish?(type)
    end
  end
end

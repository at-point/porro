require 'porro/types/any'
require 'porro/types/none'

require 'porro/types/bool'
require 'porro/types/date'
require 'porro/types/numeric'
require 'porro/types/string'

require 'porro/types/enum'
require 'porro/types/object'
require 'porro/types/collection'

require 'porro/types/blankify'
require 'porro/types/strip'

module Porro
  module Types
    TYPES = {
      bool: Porro::Types::Bool,
      date: Porro::Types::Date.new,
      integer: Porro::Types::Numeric,
      string: Porro::Types::String,
      any: Porro::Types::Any,
      none: Porro::Types::None
    }

    def self.factory(type)
      fail ArgumentError, 'type is required, was: nil' unless type
      return type if typeish?(type)

      object_factory(type) || types_factory(type).blankify
    end

    def self.object_factory(type)
      Types::Object.new(type) if type.respond_to?(:new)
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

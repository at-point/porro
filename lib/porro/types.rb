require 'porro/types/any'
require 'porro/types/bool'
require 'porro/types/date'
require 'porro/types/numeric'
require 'porro/types/string'
require 'porro/types/none'

require 'porro/types/enum'
require 'porro/types/blankified'

require 'porro/embeds/one'
require 'porro/embeds/many'

module Porro
  module Types

    TYPES = {
      bool: Porro::Types::Bool,
      date: Porro::Types::Date.new,
      integer: Porro::Types::Numeric,
      string: Porro::Types::String,
      any: Porro::Types::Any
    }

    module_function

    def factory(type)
      fail ArgumentError, "type must be #{TYPES.keys.join(', ')} or implement #dump/#load" unless supports?(type)

      return type if implements_interface?(type)
      return Embeds::One.new(type[:embeds]) if embeds_type?(type)
      return Enum.new(type) if enum_type?(type)
      Blankified.new(TYPES[type])
    end

    def supports?(type)
      implements_interface?(type) || embeds_type?(type) || enum_type?(type) || TYPES.key?(type)
    end

    def implements_interface?(type)
      %w{load dump}.all? { |method| type.respond_to?(method) }
    end

    def implements_interface!(type)
      fail ArgumentError, 'type must implement #load/#dump' unless implements_interface?(type)
    end

    def embeds_type?(type)
      type.is_a?(Hash) && type[:embeds]
    end

    def enum_type?(type)
      type.is_a?(Array)
    end
  end
end

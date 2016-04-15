require 'porro/types/base'

module Porro
  module Types
    class Struct
      attr_reader :type_map

      def initialize(type_map = {})
        @type_map = Hash[type_map.map{|(name, type)| [name.to_sym, type]}]
      end

      def load(value)
        symbolized = Hash[value.to_h.map{|(k, v)| [k.to_sym, v]}]
        type_map.each_with_object({}) do |(k, v), result|
          result[k] = v.load(symbolized[k])
        end
      end
      alias_method :dump, :load

      def to_ast
        [:type, ['struct', type_map.map{|(k,v)| [:member, [k, v.to_ast]]}]]
      end
    end
  end
end

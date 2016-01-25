require 'porro/types/any'
require 'porro/types/bool'
require 'porro/types/string'
require 'porro/types/enum'
require 'porro/types/none'

require 'porro/types/blankified'

module Porro
  module Types

    module_function

    def factory(type)
      return type if %w{load dump}.all? { |method| type.respond_to?(method) }
      return Blankified.new(Bool) if type == :bool
      return Blankified.new(String) if type == :string
      return Enum.new(type) if type.is_a?(Array)
      None
    end
  end
end

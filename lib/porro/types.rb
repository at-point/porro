require 'porro/types/any'
require 'porro/types/none'

module Porro
  module Types
    def self.factory(type)
      return type if %w{load dump}.all? { |method| type.respond_to?(method) }
      return None
    end
  end
end

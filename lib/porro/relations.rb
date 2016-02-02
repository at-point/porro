require 'porro/types/none'
require 'porro/relations/embeds_one'

module Porro
  module Relations

    module_function

    def factory(relation, type)
      return relation if %w{load dump}.all? { |method| relation.respond_to?(method) }
      return Porro::Relations::EmbedsOne.new(type) if relation == :one

      Porro::Types::None
    end
  end
end

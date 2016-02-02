require 'porro/relations/embeds_one'
require 'porro/relations/embeds_many'

require 'porro/types/none'

module Porro
  module Relations

    module_function

    def factory(relation, type)
      return relation if %w{load dump}.all? { |method| relation.respond_to?(method) }
      return Porro::Relations::EmbedsOne.new(type) if relation == :one
      return Porro::Relations::EmbedsMany.new(type) if relation == :many

      Porro::Types::None
    end
  end
end

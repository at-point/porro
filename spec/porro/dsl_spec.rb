require 'spec_helper'
require 'support/models'

require 'porro/model'

RSpec.describe 'Porro::DSL tests' do
  it 'serves to find a good DSL...'


  # class VirtusDsl
  #   include Virtus.model
  #
  #   attribute :name, String
  #   attribute :admin, Boolean
  #   attribute :address, Address
  #   attribute :emails, Set[Email]
  # end

  # class MongoIdDsl
  #   include Mongoid::Document
  #
  #   field :name, String
  #   field :admin, Boolean
  #   embeds_one :address, Address
  #   embeds_many :emails, Email
  # end

  # class JoiDsl
  #   include Porro::Model
  #
  #   schema Porro.object(
  #     name: Porro.string.strip.required('name is required'),
  #     city: Porro.string.blankify.strip,
  #     admin: Porro.boolean.optional,
  #     address: Porro.object(Address), # => delegates to Address.schema
  #     emails: Porro.collection(Joi.object(Email)).unqiue
  #   )
  # end

  #class CurrentDsl
  #  include Porro::Model
  #  attribute :name, :string
  #  attribute :admin, :bool
  #  embeds_one :address, Address
  #  embeds_many :emails, Email, as: :set
  #end

  #class ProposalV1Dsl
  #end
end

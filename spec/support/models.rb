require 'porro/model'

class MultiplyCoder < Struct.new(:factor)
  def load(value)
    value.to_i * factor
  end

  def dump(attribute)
    attribute / factor
  end
end

class Address
  include Porro::Model

  attribute :street, :string
  attribute :zip, :numeric
  attribute :city, :string
end

class Person
  include Porro::Model

  attribute :name, :string
  attribute :loves_chocolate, :bool
  attribute :strength, MultiplyCoder.new(5)

  embeds_one :address, Address
end

class Magican < Person
  attribute :strength, MultiplyCoder.new(10)
  attribute :magic, :bool
end

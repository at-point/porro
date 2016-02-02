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

class Email
  include Porro::Model
  attribute :email, :string

  def ==(other)
    return email == other.email if other.respond_to?(:email)
    super
  end
end

class Person
  include Porro::Model

  attribute :name, :string
  attribute :loves_chocolate, :bool
  attribute :strength, MultiplyCoder.new(5)

  embeds_one :address, Address
  embeds_many :emails, Email
end

class Magican < Person
  attribute :strength, MultiplyCoder.new(10)
  attribute :magic, :bool
end

require 'porro/model'
require 'porro/types'

class MultiplyType < Struct.new(:factor)
  def load(value)
    value.to_i * factor
  end

  def dump(attribute)
    attribute / factor
  end
end

class Address
  include Porro::Model

  attribute :street, Porro.string.blankify
  attribute :zip,    Porro.integer.blankify
  attribute :city,   Porro.string.blankify
end

class Email
  include Porro::Model
  attribute :email, Porro.string.email

  def ==(other)
    return email == other.email if other.respond_to?(:email)
    super
  end
end

class Person
  include Porro::Model

  attribute :name, Porro.string.blankify.strip
  attribute :loves_chocolate, Porro.bool.blankify
  attribute :strength, Porro.custom(MultiplyType.new(5)).blankify

  attribute :address, Porro.object(Address)
  attribute :emails, :set, class_name: Email
end

class Magican < Person
  attribute :strength, MultiplyType.new(10)
  attribute :magic, :bool
end

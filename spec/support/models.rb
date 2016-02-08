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

  attribute :street, :string, blankify: true
  attribute :zip,    :integer, blankify: true
  attribute :city,   :string, blankify: true
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

  attribute :name, :string, blankify: true, strip: true
  attribute :loves_chocolate, :bool, blankify: true
  attribute :strength, Porro.custom(MultiplyType.new(5)).blankify

  attribute :address, Address
  attribute :emails, :set, class_name: Email
end

class Magican < Person
  attribute :strength, MultiplyType.new(10)
  attribute :magic, :bool
end

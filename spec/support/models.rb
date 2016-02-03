require 'porro/model'

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

  attribute :street, :string
  attribute :zip, :integer
  attribute :city, :string
end

class Email
  include Porro::Model
  attribute :email, :string

  def ==(other)
    return email.to_s.downcase == other.email.to_s.downcase if other.respond_to?(:email)
    super
  end
end

class Person
  include Porro::Model

  attribute :name, :string
  attribute :loves_chocolate, :bool
  attribute :strength, MultiplyType.new(5)

  embeds_one :address, Address
  embeds_many :emails, Email

  #attribute :address, embed: Address
  #attribute :address, embed: Address, type: :array

  #attribute :address, many: Address
  #attribute :emails, array: Email
  #attribute :emails, set: Email
end

class Magican < Person
  attribute :strength, MultiplyType.new(10)
  attribute :magic, :bool
end

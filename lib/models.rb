class PersonModel
  include Porro::Model

  attribute :name, :string, strip: true
  attribute :age,  :integer
  attribute :job,  :string, blankify: true
  attribute :cool, :bool
  #attribute :favorite_numbers, Porro.set(Porro.integer)
end

require 'spec_helper'
require 'support/models'
require 'porro/model'

RSpec.describe Porro::Model do
  subject { Person.new }

  context '.porro_attributes' do
    it 'is a hash of all defined attributes' do
      expect(Person.porro_attributes).to be_a Hash
    end

    it 'has all attributes as Symbolized keys' do
      expect(Person.porro_attributes.keys).to eq [:name, :loves_chocolate, :strength, :address]
    end
  end

  context '.generate_porro_instance_accessors_for' do
    it 'creates accessors' do
      subject.name = 'Zorro'
      subject.loves_chocolate = 0
      subject.strength = 3
      subject.address = { street: 'Bahnhofstrasse 1' }

      expect(subject.name).to eq 'Zorro'
      expect(subject.loves_chocolate).to eq false
      expect(subject.strength).to eq 15
      expect(subject.address).to be_a Address
      expect(subject.address.street).to eq 'Bahnhofstrasse 1'
    end
  end

  context '#attributes' do
    subject { Person.new(name: 'Zorro', strength: 3, address: { street: 'Bahnhofstrasse 1' } ) }

    it 'returns a Hash with all keys, including embedded objects' do
      hash = {
        name: 'Zorro',
        loves_chocolate: nil,
        strength: 3,
        address: { street: 'Bahnhofstrasse 1', zip: nil, city: nil }
      }
      expect(subject.attributes).to eq hash
    end
  end

  context 'inheritance' do
    subject { Magican.new }

    it 'has more attributes' do
      expect(Magican.porro_attributes.keys).to eq [:name, :loves_chocolate, :strength, :address, :magic]
      expect(Person.porro_attributes.keys).to eq [:name, :loves_chocolate, :strength, :address]
    end

    it 'creates additional accessors' do
      subject.name = 'Zorro'
      subject.loves_chocolate = 0
      subject.strength = 3
      subject.magic = false

      expect(subject.name).to eq 'Zorro'
      expect(subject.loves_chocolate).to eq false
      expect(subject.strength).to eq 30
      expect(subject.magic).to be_falsey
    end
  end
end

require 'spec_helper'
require 'porro/model'

class MultiplyCoder < Struct.new(:factor)
  def load(value)
    value.to_i * factor
  end
end

class SomeObject
  include Porro::Model

  attribute :name, :string
  attribute :loves_chocolate, :bool
  attribute :strength, MultiplyCoder.new(5)
end

class UberObject < SomeObject
  attribute :strength, MultiplyCoder.new(10)
  attribute :magic, :bool
end

RSpec.describe Porro do
  it 'has a version number' do
    expect(Porro::VERSION).not_to be nil
  end

  context '::Model' do
    subject { SomeObject.new }

    it 'has attributes' do
      expect(SomeObject.porro_attributes).to eq Set.new([:name, :loves_chocolate, :strength])
    end

    it 'creates accessors' do
      subject.name = 'Zorro'
      subject.loves_chocolate = 0
      subject.strength = 3

      expect(subject.name).to eq 'Zorro'
      expect(subject.loves_chocolate).to eq false
      expect(subject.strength).to eq 15
    end
  end

  context '::UberObject' do
    subject { UberObject.new }

    it 'has more attributes' do
      expect(UberObject.porro_attributes).to eq Set.new([:name, :loves_chocolate, :strength, :magic])
      expect(SomeObject.porro_attributes).to eq Set.new([:name, :loves_chocolate, :strength])
    end

    it 'creates accessors' do
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

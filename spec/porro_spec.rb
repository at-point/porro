require 'spec_helper'
require 'porro/model'

class MultiplyCoder < Struct.new(:factor)
  def load(value)
    value.to_i * factor
  end
end

class SomeObject
  extend Porro::Model

  attribute name: :string,
            loves_chocolate: :bool,
            strength: MultiplyCoder.new(5)
end

class UberObject < SomeObject
  attribute strength: MultiplyCoder.new(10),
            magic: :bool
end

RSpec.describe Porro do
  it 'has a version number' do
    expect(Porro::VERSION).not_to be nil
  end

  context '::Coders' do
    context '.factory' do
      it 'returns a StringCoder for :string' do
        expect(Porro::Coders.factory(:string)).to eq Porro::Coders::StringCoder
      end

      it 'returns a BooleanCoder for :bool' do
        expect(Porro::Coders.factory(:bool)).to eq Porro::Coders::BooleanCoder
      end

      it 'returns an AnyType for itself' do
        expect(Porro::Coders.factory(Porro::Coders::AnyCoder)).to eq Porro::Coders::AnyCoder
      end
    end
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

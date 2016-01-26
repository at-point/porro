require 'spec_helper'
require 'support/shared_type'

require 'porro/types'

class TypesSpecType
  def self.load(arg); 'LOAD' end
  def self.dump(arg); 'DUMP' end
end

RSpec.describe Porro::Types do
  subject { described_class }

  context '.factory' do
    it 'returns the type itself if it quacks like a type' do
      expect(subject.factory(TypesSpecType)).to eq TypesSpecType
    end

    it 'returns None for nil' do
      expect(subject.factory(nil)).to eq Porro::Types::None
    end

    it 'returns None for anything else' do
      expect(subject.factory('hello')).to eq Porro::Types::None
    end

    it 'returns a Blankified.new(Bool) for :bool' do
      type = subject.factory(:bool)
      expect(type).to be_a Porro::Types::Blankified
      expect(type.wrapped).to eq Porro::Types::Bool
    end

    it 'returns a Blankified.new(String) for :string' do
      type = subject.factory(:string)
      expect(type).to be_a Porro::Types::Blankified
      expect(type.wrapped).to eq Porro::Types::String
    end

    it 'returns a Blankified.new(Date) for :date' do
      type = subject.factory(:date)
      expect(type).to be_a Porro::Types::Blankified
      expect(type.wrapped).to be_a Porro::Types::Date
    end

    it 'returns a Blankified.new(Numeric) for :integer' do
      type = subject.factory(:integer)
      expect(type).to be_a Porro::Types::Blankified
      expect(type.wrapped).to be Porro::Types::Numeric
    end
  end
end

require 'spec_helper'
require 'support/models'

require 'porro/types'

class TypesSpecType
  def self.load(arg); 'LOAD' end
  def self.dump(arg); 'DUMP' end
end

RSpec.describe Porro::Types do
  subject { described_class }
  let(:custom_type) { MultiplyType.new(3) }

  context '.factory' do
    it 'returns the type itself if it quacks like a type' do
      expect(subject.factory(custom_type)).to be custom_type
    end

    it 'raises ArgumentError for nil' do
      expect { subject.factory(nil) }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError for anything else' do
      expect { subject.factory('hello') }.to raise_error(ArgumentError)
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

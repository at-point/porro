require 'spec_helper'
require 'support/models'
require 'support/type_matchers'

require 'porro/types'

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

    it 'returns a Blankify.new(Bool) for :bool' do
      expect(subject.factory(:bool)).to be_a_blankified_with(Porro::Types::Bool)
    end

    it 'returns a Blankify.new(String) for :string' do
      expect(subject.factory(:string)).to be_a_blankified_with(Porro::Types::String)
    end

    it 'returns a Blankify.new(Date) for :date' do
      expect(subject.factory(:date)).to be_a_blankified_with(Porro::Types::Date)
    end

    it 'returns a Blankify.new(Numeric) for :integer' do
      expect(subject.factory(:integer)).to be_a_blankified_with(Porro::Types::Numeric)
    end
  end
end

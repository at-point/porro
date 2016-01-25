require 'spec_helper'
require 'support/shared_type'

require 'porro/types'

class TypesSpecType
  def self.load(arg); "LOAD" end
  def self.dump(arg); "DUMP" end
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
  end
end

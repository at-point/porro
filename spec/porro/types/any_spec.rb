require 'spec_helper'
require 'support/shared_type'

require 'porro/types/any'

RSpec.describe Porro::Types::Any do
  subject { described_class }
  it_behaves_like 'a Type'

  context '#load' do
    it 'returns a String as-is' do
      expect(subject.load('foo')).to eq 'foo'
    end

    it 'returns nil as-is' do
      expect(subject.load(nil)).to eq nil
    end

    it 'returns any Object as is' do
      object = Struct.new(:foo).new("bar")
      expect(subject.load(object)).to eq object
    end
  end
end

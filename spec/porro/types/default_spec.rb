require 'spec_helper'
require 'support/shared_type'

require 'porro/types/default'
require 'porro/types/any'

RSpec.describe Porro::Types::Default do
  subject { described_class.new(Porro::Types::Any, default_value) }
  let!(:default_value) { 'cheese cake' }
  it_behaves_like 'a Type'

  context '#load' do
    it 'converts to cheese cake for nil' do
      expect(subject.load(nil)).to eq default_value
    end

    it 'does not touch 0' do
      expect(subject.load(0)).to eq 0
    end
  end

  context '#dump' do
  end
end

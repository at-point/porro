require 'spec_helper'
require 'support/shared_type'

require 'porro/types/default'
require 'porro/types/any'

RSpec.describe Porro::Types::Default do
  let(:default_literal) { 'a default' }
  let(:default_callable) { -> { default_literal } }
  let(:specific_value) { 'a specific' }

  it_behaves_like 'a Type'

  %w{literal callable}.each do |type|
    subject { described_class.new(Porro::Types::Any, send("default_#{type}")) }

    context "#load with default #{type}" do
      it 'converts to default for nil' do
        expect(subject.load(nil)).to eq default_literal
      end

      it 'does not touch a specific value' do
        expect(subject.load(specific_value)).to eq specific_value
      end
    end

    context "#dump with default #{type}" do
      it 'dumps the default' do
        expect(subject.dump(nil)).to eq default_literal
      end

      it 'dumps the specific value' do
        expect(subject.dump(specific_value)).to eq specific_value
      end
    end
  end
end

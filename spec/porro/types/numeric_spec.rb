require 'spec_helper'
require 'support/shared_type'

require 'porro/types/numeric'

RSpec.describe Porro::Types::Numeric do
  subject { described_class }
  it_behaves_like 'a Type'

  # Feeling lazy...
  %w{load dump}.each do |method|
    context "##{method}" do
      it 'converts nil to 0' do
        expect(subject.send(method, nil)).to eq 0
      end

      it 'converts empty string to 0' do
        expect(subject.send(method, '')).to eq 0
      end

      it 'converts string to Fixnum' do
        expect(subject.send(method, '42')).to eq 42
      end

      it 'leaves Fixnum as-is' do
        expect(subject.send(method, 42)).to eq 42
      end
    end
  end
end

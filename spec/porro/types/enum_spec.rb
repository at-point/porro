require 'spec_helper'
require 'support/shared_type'

require 'porro/types/enum'

RSpec.describe Porro::Types::Enum do
  subject { described_class.new(%w{male female}, default_value: 'female') }
  it_behaves_like 'a Type'

  # Feeling a bit lazy...
  %w{load dump}.each do |method|
    context "##{method}" do
      it 'converts nil to the default (female)' do
        expect(subject.send(method, nil)).to eq 'female'
      end

      it 'converts empty String to the default (female)' do
        expect(subject.send(method, '')).to eq 'female'
      end

      it 'converts anything else to default (female)' do
        expect(subject.send(method, 'FOOBAR')).to eq 'female'
      end

      it 'leaves "male" as is' do
        expect(subject.send(method, 'male')).to eq 'male'
      end

      it 'leaves "female" as is' do
        expect(subject.send(method, 'female')).to eq 'female'
      end

      it 'converts input to String' do
        expect(subject.send(method, :female)).to eq 'female'
      end

      it 'does not strip / mangle input => returns default' do
        expect(subject.send(method, "  male\t")).to eq 'female'
      end
    end
  end
end

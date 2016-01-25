require 'spec_helper'
require 'support/shared_type'

require 'porro/types/string'

RSpec.describe Porro::Types::String do
  subject { described_class }
  it_behaves_like 'a Type'

  # Feeling a bit lazy...
  %w{load dump}.each do |method|
    context "##{method}" do
      it 'converts nil to empty String' do
        expect(subject.send(method, nil)).to eq ''
      end

      it 'leaves Strings as is' do
        expect(subject.send(method, 'some string')).to eq 'some string'
      end

      it 'does not strip / mangle input' do
        expect(subject.send(method, " More Input\t")).to eq " More Input\t"
      end

      it 'converts anything to a String' do
        expect(subject.send(method, %w{hi})).to eq '["hi"]'
      end
    end
  end
end

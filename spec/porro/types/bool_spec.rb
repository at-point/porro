require 'spec_helper'
require 'support/shared_type'

require 'porro/types/bool'

RSpec.describe Porro::Types::Bool do
  subject { described_class }
  it_behaves_like 'a Type'

  context '#load' do
    context 'truthy' do
      it 'accepts true' do
        expect(subject.load(true)).to eq true
      end

      it 'accepts 1' do
        expect(subject.load(1)).to eq true
      end

      it 'accepts 100' do
        expect(subject.load(100)).to eq true
      end

      it 'accepts -100' do
        expect(subject.load(-100)).to eq true
      end

      it 'accepts "true"' do
        expect(subject.load('true')).to eq true
      end

      it 'accepts "TRUE"' do
        expect(subject.load('TRUE')).to eq true
      end

      it 'accepts "any non empty string"' do
        expect(subject.load('any non empty string')).to eq true
      end
    end

    context 'falsey' do
      it 'accepts false' do
        expect(subject.load(false)).to eq false
      end

      it 'accepts 0' do
        expect(subject.load(0)).to eq false
      end

      it 'accepts "false"' do
        expect(subject.load('false')).to eq false
      end

      it 'accepts "FALSE"' do
        expect(subject.load('FALSE')).to eq false
      end

      it 'accepts nil' do
        expect(subject.load(nil)).to eq false
      end

      it 'accepts "" (empty string)' do
        expect(subject.load('')).to eq false
        expect(subject.load("\t ")).to eq false
      end
    end
  end
end

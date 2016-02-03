require 'spec_helper'
require 'support/shared_type'

require 'porro/types'

RSpec.describe Porro::Types::Blankified do
  subject { described_class.new(Porro::Types::Any) }
  it_behaves_like 'a Type'

  context '#load' do
    it 'converts to nil for nil' do
      expect(subject.load(nil)).to eq nil
    end

    it 'converts to nil for empty String' do
      expect(subject.load('')).to eq nil
    end

    it 'converts to nil for blank String' do
      expect(subject.load("\t ")).to eq nil
    end

    it 'converts to nil for empty Array' do
      expect(subject.load([])).to eq nil
    end

    it 'converts to nil for empty Hash' do
      expect(subject.load({})).to eq nil
    end

    it 'does not touch false' do
      expect(subject.load(false)).to eq false
    end

    it 'does not touch 0' do
      expect(subject.load(0)).to eq 0
    end

    it 'does not touch a String' do
      expect(subject.load('Hello World')).to eq 'Hello World'
    end

    it 'does not touch some Array' do
      expect(subject.load(%w{zorro})).to eq %w{zorro}
    end
  end

  context '#dump' do
  end
end

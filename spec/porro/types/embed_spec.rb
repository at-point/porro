require 'spec_helper'
require 'support/shared_type'
require 'support/models'

require 'porro/types/embed'

RSpec.describe Porro::Types::Embed do
  subject { described_class.new(Address) }

  context 'compliance' do
    before { allow(subject).to receive(:warn).with(/unable to dump object of type Address/) }
    it_behaves_like 'a Type'
  end

  it 'TBD: should maybe delegate to embedded klass as a factory?'

  context '#load' do
    let(:fake) { Address.new(street: 'Bahnhofstrasse 1') }

    it 'returns a new instance' do
      expect(subject.load(nil)).to be_a(Address)
    end

    it 'passes the arguments to the constructor' do
      expect(subject.load(street: 'Bahnhofstrasse 1').street).to eq 'Bahnhofstrasse 1'
    end

    it 'returns the same object if already of correct class' do
      expect(subject.load(fake)).to be fake
    end
  end

  context '#dump' do
    it 'TBD: should maybe warn or fail when invalid type is passed, e.g. not an EmbedFake instance?'

    it 'dumps if it responds to #attributes' do
      expect(subject.dump(double(attributes: 'attributes'))).to eq 'attributes'
    end

    it 'dumps if it responds to #to_hash' do
      expect(subject.dump(double(to_hash: 'attributes'))).to eq 'attributes'
    end

    it 'dumps if it responds to #to_h' do
      expect(subject.dump(double(to_h: 'attributes'))).to eq 'attributes'
    end

    it 'produces a warning and returns empty hash if none of these methods are implemented' do
      expect(subject).to receive(:warn).with(/unable to dump object of type Address/)
      expect(subject.dump(double())).to eq Hash.new
    end
  end
end

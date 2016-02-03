require 'spec_helper'
require 'support/shared_type'
require 'support/models'

require 'porro/relations/embeds_many'

RSpec.describe Porro::Relations::EmbedsMany do
  subject { described_class.new(Email) }
  it_behaves_like 'a Type'

  let(:personal) { Email.new(email: 'private@example.com') }
  let(:work) { Email.new(email: 'work@example.com') }

  context '.factory' do
    subject { described_class }

    it 'raises ArgumentError for nil' do
      expect { subject.factory(nil) }.to raise_error ArgumentError
    end

    it 'raises ArgumentError for anything that does not implement #new' do
      expect { subject.factory('String') }.to raise_error ArgumentError
    end


  end

  context '#load' do
    it 'returns an empty Array' do
      expect(subject.load(nil)).to eq []
    end

    it 'passes the arguments to the constructor' do
      ary = [{ email: 'private@example.com' }]
      expect(subject.load(ary)).to eq [personal]
    end

    it 'returns the same object if already of correct class' do
      expect(subject.load([personal, work])).to eq [personal, work]
    end

    context 'with a Set' do
      subject { described_class.new(String, Set) }

      it 'returns an empty Set' do
        expect(subject.load(nil)).to be_a Set
        expect(subject.load(nil)).to eq Set.new
      end

      it 'is a Set, so emails are not added multiple times' do
        ary = %w{work@example.com private@example.com work@example.com}
        expect(subject.load(ary)).to eq Set.new(%w{work@example.com private@example.com})
      end
    end
  end

  context '#dump' do
    it 'dumps empty Array if not an Array' do
      expect(subject.dump(nil)).to eq []
    end

    it 'dumps if it responds to #attributes' do
      result = [{ email: 'private@example.com' }]
      expect(subject.dump([personal])).to eq result
    end

    it 'dumps if inner object responds to #to_hash' do
      expect(subject.dump([double(to_hash: 'attributes')])).to eq %w{attributes}
    end

    it 'dumps if inner object responds to #to_h' do
      expect(subject.dump([double(to_h: 'attributes')])).to eq %w{attributes}
    end

    it 'produces a warning and returns empty hash if none of these methods are implemented' do
      expect(subject.embedder).to receive(:warn).with(/unable to dump object of type Email/)
      expect(subject.dump([double()])).to eq [Hash.new]
    end
  end
end

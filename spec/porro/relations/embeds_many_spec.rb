require 'spec_helper'
require 'support/shared_type'
require 'support/models'

require 'porro/relations/embeds_many'

RSpec.describe Porro::Relations::EmbedsMany do
  subject { described_class.new(Email) }
  it_behaves_like 'a Type'

  it 'TBD: should maybe allow to define use of Set vs Array'

  let(:personal) { Email.new(email: 'private@example.com') }
  let(:work) { Email.new(email: 'work@example.com') }

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

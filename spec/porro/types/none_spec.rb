require 'spec_helper'
require 'support/shared_type'

require 'porro/types/none'

RSpec.describe Porro::Types::None do
  subject { described_class }
  it_behaves_like 'a Type'

  context '#load' do
    it 'returns nil, always...' do
      expect(subject.load('foo')).to be_nil
      expect(subject.load(13)).to be_nil
      expect(subject.load(nil)).to be_nil
    end
  end
end

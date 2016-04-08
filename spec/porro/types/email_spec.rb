require 'spec_helper'
require 'support/shared_type'

require 'porro/types/email'

RSpec.describe Porro::Types::Email do
  subject { described_class }
  it_behaves_like 'a Type', supports: %w{strip blankify}

  it 'is exposed as Porro.string.email' do
    expect(Porro.string.email).to be subject
  end

  # Feeling a bit lazy...
  %w{load dump}.each do |method|
    context "##{method}" do
      it 'converts nil to the nil' do
        expect(subject.send(method, nil)).to be_nil
      end

      it 'converts empty String to the nil' do
        expect(subject.send(method, '')).to be_nil
      end

      it 'converts anything else to nil' do
        expect(subject.send(method, 'FOOBAR')).to be_nil
      end

      it 'converts "invalid" email to nil"' do
        expect(subject.send(method, 'foobar@foo')).to be_nil
      end

      it 'accepts valid e-mail' do
        expect(subject.send(method, 'zorro@example.com')).to eq 'zorro@example.com'
      end

      it 'strips and downcases the e-mail' do
        expect(subject.send(method, "  ZORRO@EXAMPLE.COM\t\n")).to eq 'zorro@example.com'
      end

      it 'accepts e-mails with + sign' do
        expect(subject.send(method, "zorro+more@example.com")).to eq 'zorro+more@example.com'
      end
    end
  end
end

RSpec.shared_examples 'a Type' do
  let(:data) { 'data' }

  context '#load' do
    it 'responds #load' do
      expect(subject).to respond_to(:load)
    end

    it 'does not raise an exception' do
      expect { subject.load(data) }.to_not raise_error
    end
  end

  context '#dump' do
    it 'responds to #dump' do
      expect(subject).to respond_to(:dump)
    end

    it 'does not raise an exception' do
      expect { subject.dump(data) }.to_not raise_error
    end
  end
end

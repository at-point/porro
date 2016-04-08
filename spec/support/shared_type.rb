RSpec.shared_examples 'a Type' do |supports: %w{blankify strip default}, data: 'data'|
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

  if supports && !supports.empty?
    context 'Base DSL support' do
      supports.each do |method|
        it "responds to ##{method}" do
          expect(subject).to respond_to(method)
        end

        it "returns a typeish too" do
          args = method == 'default' ? %w{default} : []
          type = subject.public_send(method, *args)

          expect(type).to respond_to(:load)
          expect(type).to respond_to(:dump)
        end
      end
    end
  else
    it 'does not support Base DSL (e.g. blankify, strip, default)'
  end
end

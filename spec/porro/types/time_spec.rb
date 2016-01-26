require 'spec_helper'
require 'timecop'
require 'support/shared_type'

require 'porro/types/time'

RSpec.describe Porro::Types::Time do
  subject { described_class.new }
  it_behaves_like 'a Type'

  let(:time) { ::Time.gm(2012, 4, 23, 18, 25, 43, 511000)}

  context '#load' do
    it 'is able to read a 2012-04-23T18:25:43.511Z time' do
      expect(subject.load('2012-04-23T18:25:43.511Z')). to eq time
    end

    it 'is able to read a DD.MM.YYYY time' do
      expect(subject.load('23.4.2012 18:25:43.511Z')).to eq time
    end
  end

  context '#dump' do
    it 'correctly exposes the UTC time' do
      expect(subject.dump(time)).to eq '2012-04-23T18:25:43.511Z'
    end
  end
end

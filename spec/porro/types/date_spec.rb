require 'spec_helper'
require 'support/shared_type'

require 'porro/types/date'

RSpec.describe Porro::Types::Date do
  subject { described_class.new }
  it_behaves_like 'a Type'

  let(:date) { ::Date.new(2012, 4, 23) }

  context '#load' do
    it 'is able to read a 2012-04-23' do
      expect(subject.load('2012-04-23')). to eq date
    end

    it 'is able to read a DD.MM.YYYY date' do
      expect(subject.load('23.4.2012')).to eq date
    end

    it 'is able to read a JSON time' do
      expect(subject.load('2012-04-23T00:00:00.000Z')).to eq date
    end
  end

  context '#dump' do
    it 'correctly exposes the date as UTC time' do
      expect(subject.dump(date)).to eq '2012-04-23T00:00:00.000Z'
    end
  end
end

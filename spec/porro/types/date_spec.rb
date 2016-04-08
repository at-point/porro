require 'date'
require 'spec_helper'
require 'support/shared_type'

require 'porro/types/date'

RSpec.describe Porro::Types::Date do
  subject { described_class }
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

    it 'returns nil for nil' do
      expect(subject.load(nil)).to eq nil
    end

    it 'returns nil for invalid value' do
      expect(subject.load('definitely-not-a-date')).to eq nil
    end
  end

  context '#default' do
    let(:today) { Date.today }
    subject { described_class.default(-> { date }) }

    it 'sets the default' do
      expect(subject.load(nil)).to eq date
    end

    it 'can override the default with a specific' do
      expect(subject.load(today)).to eq today
    end

    it 'can dumps the specific value' do
      expect(subject.dump(today)).to eq today.strftime(Porro::Types::Date::DATE_FORMAT)
    end

    it 'dumps the default' do
      expect(subject.dump(nil)).to eq '2012-04-23T00:00:00.000Z'
    end
  end


  context '#dump' do
    it 'correctly exposes the date as UTC time' do
      expect(subject.dump(date)).to eq '2012-04-23T00:00:00.000Z'
    end
  end
end

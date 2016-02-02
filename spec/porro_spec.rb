require 'spec_helper'
require 'porro'

RSpec.describe Porro do
  it 'has a version number' do
    expect(Porro::VERSION).not_to be nil
  end

  it 'exposes Porro::Model' do
    expect(Porro::Model).to be_a Module
  end
end

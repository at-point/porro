# For Porro::Types::Blankified
RSpec::Matchers.define :be_a_blankified_with do |expected|
  match do |actual|
    actual.is_a?(Porro::Types::Blankified) &&
      (actual.wrapped == expected || actual.wrapped.is_a?(expected))
  end
end

# For Porro::Relations::EmbedsOne
RSpec::Matchers.define :be_an_embeds_one_with do |expected|
  match do |actual|
    actual.is_a?(Porro::Embeds::One) &&
      actual.klass == expected
  end
end

# For Porro::Relations::EmbedsMany
RSpec::Matchers.define :be_an_embeds_many_as do |expected|
  match do |actual|
    actual.is_a?(Porro::Embeds::Many) &&
      actual.collection_klass == expected
  end
end

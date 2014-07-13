require 'rspec/expectations'

RSpec::Matchers.define :be_json_eq do |expected|
  match do |actual|
    actual.to_json == expected.to_json
  end

  failure_message do |actual|
    "expected that #{actual.to_json} would eq #{expected.to_json}"
  end
end

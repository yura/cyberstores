RSpec::Matchers.define :have_store_name do |expected|
  match do |actual|
    actual.has_css?('.store-name', text: expected)
  end

  description do
    "have '#{expected}' store name"
  end

  failure_message do |obj|
    "expected that the page would have '#{expected}' store name"
  end

  failure_message_when_negated do |obj|
    "expected that the page would not have '#{expected}' store name"
  end
end

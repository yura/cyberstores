# frozen_string_literal: true

RSpec.configure do |config|
  config.include Capybara::DSL
end

# Snippet got from the https://robots.thoughtbot.com/acceptance-tests-with-subdomains
Capybara.configure do |config|
  config.always_include_port = true
end

def visit_store(store, path = '/')
  app_host = URI.join("http://#{store.subdomain}.cyberstores.dev", path).to_s
  using_app_host(app_host) do
    visit path
  end
end

def using_app_host(host)
  original_host = Capybara.app_host
  Capybara.app_host = host
  yield
ensure
  Capybara.app_host = original_host
end

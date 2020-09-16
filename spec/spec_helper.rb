# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'rspec_api_documentation'
require 'api_documentation_helper'

module SpecTestHelper
  def sign_in(user = nil)
    user ||= User.create!(email: 'spec_test_helper@qq.com', password: '123456', password_confirmation: '123456')
    post '/sessions', params: {email: user.email, password: user.password}
    user
  end
end

RSpec.configure do |config|
  config.include SpecTestHelper, :type => :request

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

=begin
  config.filter_run_when_matching :focus

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.disable_monkey_patching!

  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = "doc"
  end
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
=end
end

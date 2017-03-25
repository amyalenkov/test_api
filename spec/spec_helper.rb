require 'rspec/json_expectations'

require_relative '../helper/test_environment'
require_relative '../helper/expected_countries'

env = TestEnvironment.get_test_environment


Airborne.configure do |config|
  config.base_url = env['host']
end
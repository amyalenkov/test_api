require 'rspec/json_expectations'

require_relative '../helper/test_environment'
require_relative '../helper/entities/area'
require_relative '../helper/entities/employer'
require_relative '../helper/entities/vacancy'


env = TestEnvironment.get_test_environment


Airborne.configure do |config|
  config.base_url = env['host']
end
require 'rspec/json_expectations'
require 'httplog'
require 'allure-rspec'

require_relative '../helper/test_environment'
require_relative '../helper/entities/area'
require_relative '../helper/entities/employer'
require_relative '../helper/entities/vacancy'


env = TestEnvironment.get_test_environment


Airborne.configure do |config|
  config.base_url = env['host']
end

RSpec.configure do |c|
  c.include AllureRSpec::Adaptor
end

AllureRSpec.configure do |c|
  c.output_dir = '/allure-results'
  c.clean_dir = true
  c.logging_level = Logger::DEBUG
end

HttpLog.configure do |config|


  config.logger = Logger.new('| tee logs/test.log')

  config.severity = Logger::Severity::DEBUG


  config.log_connect   = false
  config.log_request   = true
  config.log_headers   = false
  config.log_data      = true
  config.log_status    = true
  config.log_response  = true
  config.log_benchmark = false

  config.compact_log = false

  config.color = false

  config.url_whitelist_pattern = /.*/
  config.url_blacklist_pattern = nil
end
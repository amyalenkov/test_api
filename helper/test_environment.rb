require 'yaml'

class TestEnvironment

  @@env_variable_name = 'TEST_ENV'
  @@directory_for_envs = 'environment/'

  def self.get_test_environment
    file_name = get_file_name
    check_available_file_name file_name
    YAML.load_file(@@directory_for_envs + file_name)
  end


  private

  def self.get_file_name
    if ENV[@@env_variable_name].nil?
      raise ArgumentError, '\' ' + @@env_variable_name + ' \' is absent in command line.'
    else
      ENV[@@env_variable_name]
    end
  end

  def self.check_available_file_name(file_name)
    unless File.file?(@@directory_for_envs + file_name)
      raise StandardError, 'file \'' + file_name + '\' is absent in directory \'' + @@directory_for_envs + '\'. ' +
          'Please, use one of the next file name for environment definition: ' + Dir[@@directory_for_envs +'*.yml'].to_s +
          '. Also you can add file in directory \'' + @@directory_for_envs + '\' and use it for yourself.'
    end
  end


end
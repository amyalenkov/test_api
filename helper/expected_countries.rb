class ExpectedCountries

  @@expected_data_directory = 'expected_data/'

  def initialize(file_name)
    @expected_countries = load_expected_countries file_name
  end

  def get_expected_countries
    @expected_countries
  end

  def get_expected_countries_by_name(name)
    @expected_countries.find { |country| country['name'] == name.to_s }
  end

  private

  def load_expected_countries(file_name)
    file_path = @@expected_data_directory + file_name
    unless File.file?(file_path)
      raise StandardError, 'file \'' + file_name + '\' is absent in directory \'' + @@expected_data_directory + '\'.'
    end
    JSON.parse(File.read(file_path))
  end


end
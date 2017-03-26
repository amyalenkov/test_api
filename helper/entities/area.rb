class Area

  @@expected_data_directory = 'expected_data/'

  def initialize(areas_file_name, country_file_name)
    @countries = load_expected_data country_file_name
    @areas = load_expected_data areas_file_name
  end

  def self.get_areas_url
    '/areas'
  end

  def self.get_areas_by_area_id_url(area_id)
    get_areas_url + '/' + area_id
  end

  def self.get_countries_url
    get_areas_url + '/countries'
  end

  def self.get_countries_by_id_url(country_id)
    self.get_countries_url + '/' + country_id
  end

  def get_expected_countries
    @countries
  end

  def get_expected_areas
    @areas
  end

  def get_expected_countries_by_name(name)
    @countries.find { |country| country['name'] == name.to_s }
  end

  def get_area_id_by_name(county, city)
    area_id = get_expected_countries_by_name(county)['id']
    rus = @areas.find { |areas| areas['id'] == area_id.to_s}
    rus['areas'].find { |areas| areas['name'] == city.to_s}['id']
  end

  private

  def load_expected_data(file_name)
    file_path = @@expected_data_directory + file_name
    unless File.file?(file_path)
      raise StandardError, 'file \'' + file_name + '\' is absent in directory \'' + @@expected_data_directory + '\'.'
    end
    JSON.parse(File.read(file_path))
  end
end
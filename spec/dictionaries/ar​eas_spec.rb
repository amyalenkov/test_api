require 'airborne'
require 'spec_helper'


describe 'areas' do

  before(:all) do
    @areas = Area.new 'areas.json', 'countries.json'
  end

  context 'check areas endpoint' do
    it 'get all available areas' do
      get Area.get_areas_url
      expect_status 200
      puts body
      expect(body).to include_json(@areas.get_expected_areas)
    end
  end

  context 'check areas by id endpoint' do
    it 'get all available areas by id' do
      area_id = @areas.get_expected_countries_by_name('Россия')['id']
      get Area.get_areas_by_area_id_url area_id.to_s
      expect_status 200
      expected_areas_by_id = @areas.get_expected_areas.find { |areas| areas['id'] == area_id.to_s}
      expect(body).to include_json(expected_areas_by_id)
    end
  end

  context 'check countries endpoint' do

    it 'get all available countries' do
      get Area.get_countries_url
      expect_status 200
      expect_json_types('*', url: :string, id: :string, name: :string)
      expect_json_keys('*', [:url, :id, :name])
      expect(body).to include_json(@areas.get_expected_countries)
    end

    it 'try to get country by id' do
      country_id = @areas.get_expected_countries_by_name('Россия')['id']
      get Area.get_countries_by_id_url country_id.to_s
      expect_status 405
    end

    it 'try to create new country' do
      post Area.get_countries_url, {'url': 'https://api.hh.ru/areas/111111', 'id': '111111', 'name': 'NewCountry'}
      expect_status 405
    end

    it 'try to update new country' do
      put Area.get_countries_url, {'url': 'https://api.hh.ru/areas/111111', 'id': '111111', 'name': 'NewCountry'}
      expect_status 405
    end

    it 'try to delete country' do
      country_id = @areas.get_expected_countries_by_name('Россия')['id']
      delete Area.get_countries_by_id_url country_id.to_s
      expect_status 405
    end

  end


end
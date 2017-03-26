require 'airborne'
require 'spec_helper'


describe 'areas' do

  before(:all) do
    @areas = Area.new 'areas.json', 'countries.json'
  end

  context 'check areas endpoint' do
    it 'get all available areas', :severity => :critical, :testId => 1 do |e|
      e.step 'GET '+Area.get_areas_url do
        get Area.get_areas_url
      end
      e.step 'check status and body' do
        expect_status 200
        expect(body).to include_json(@areas.get_expected_areas)
      end
    end
  end

  context 'check areas by id endpoint' do
    it 'get all available areas by id', :severity => :critical, :testId => 2 do |e|
      area_id = @areas.get_expected_countries_by_name('Россия')['id']
      e.step 'GET '+Area.get_areas_by_area_id_url(area_id) do
        get Area.get_areas_by_area_id_url area_id.to_s
      end
      e.step 'check status and body' do
        expect_status 200
        expected_areas_by_id = @areas.get_expected_areas.find { |areas| areas['id'] == area_id.to_s }
        expect(body).to include_json(expected_areas_by_id)
      end
    end
  end

  context 'check countries endpoint' do

    it 'get all available countries', :severity => :critical, :testId => 3 do |e|
      e.step 'GET '+Area.get_countries_url do
        get Area.get_countries_url
      end
      e.step 'check status and body' do
        expect_status 200
        expect_json_types('*', url: :string, id: :string, name: :string)
        expect_json_keys('*', [:url, :id, :name])
        expect(body).to include_json(@areas.get_expected_countries)
      end
    end

    it 'try to get country by id', :severity => :low, :testId => 4 do |e|
      country_id = @areas.get_expected_countries_by_name('Россия')['id']
      e.step 'GET '+Area.get_areas_by_area_id_url(country_id) do
        get Area.get_countries_by_id_url country_id.to_s
      end
      e.step 'check status' do
        expect_status 405
      end
    end

    it 'try to create new country', :severity => :low, :testId => 5 do |e|
      e.step 'POST '+Area.get_countries_url do
        post Area.get_countries_url, {'url': 'https://api.hh.ru/areas/111111', 'id': '111111', 'name': 'NewCountry'}
      end
      e.step 'check status' do
        expect_status 405
      end
    end

    it 'try to update new country', :severity => :low, :testId => 6 do |e|
      e.step 'PUT '+Area.get_countries_url do
        put Area.get_countries_url, {'url': 'https://api.hh.ru/areas/111111', 'id': '111111', 'name': 'NewCountry'}
      end
      e.step 'check status' do
        expect_status 405
      end
    end

    it 'try to delete country', :severity => :low, :testId => 7 do |e|
      country_id = @areas.get_expected_countries_by_name('Россия')['id']

      e.step 'DELETE '+Area.get_countries_by_id_url(country_id.to_s) do
        delete Area.get_countries_by_id_url country_id.to_s
      end
      e.step 'check status' do
        expect_status 405
      end
    end

  end


end
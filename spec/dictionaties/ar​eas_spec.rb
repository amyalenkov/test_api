require 'airborne'
require 'spec_helper'


describe 'areas' do

  before(:all) do
    @expected_countries = ExpectedCountries.new 'countries.json'
  end

  context 'check areas endpoint' do

  end

  context 'check areas by id endpoint' do

  end

  context 'check countries endpoint' do

    it 'get all available countries' do
      get '/areas/countries'
      expect_status 200
      expect_json_types('*', url: :string, id: :string, name: :string)
      expect_json_keys('*', [:url, :id, :name])
      expect(body).to include_json(@expected_countries.get_expected_countries)
    end

    it 'try to get country by id' do
      country_id = @expected_countries.get_expected_countries_by_name('Россия')['id']
      get '/areas/countries/'+ country_id.to_s
      puts body
      expect_status 405
    end

    it 'try to create new country' do
      post '/areas/countries', {'url': 'https://api.hh.ru/areas/111111', 'id': '111111', 'name': 'NewCountry'}
      expect_status 405
    end

    it 'try to update new country' do
      put '/areas/countries', {'url': 'https://api.hh.ru/areas/111111', 'id': '111111', 'name': 'NewCountry'}
      expect_status 405
    end

    it 'try to delete country' do
      country_id = @expected_countries.get_expected_countries_by_name('Россия')['id']
      delete '/areas/countries/'+ country_id.to_s
      expect_status 405
    end

  end


end
require 'airborne'
require 'spec_helper'


describe 'employers' do

  before(:all) do
    @expected_countries = ExpectedCountries.new 'countries.json'
  end

  context 'check employers endpoint' do

    it 'get all employers without params' do
      get '/employers'
      expect_status 200
    end

    it 'get all employers with params: text, area' do
      company_name ='Новые Облачные Технологии'
      area_id = @expected_countries.get_expected_countries_by_name('Россия')['id']
      get '/employers', {params: {text: company_name,
                                      area: area_id}}
      expect_status 200
      expect_json('found', 1)
      expect_json('items.0.name', company_name)
    end


  end

  context 'check employers by id endpoint' do

  end

end
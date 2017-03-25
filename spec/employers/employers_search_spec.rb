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
      expect_json_types(found: :int, page: :int, per_page: :int)
      expect_json_types('items.*.logo_urls', '90': :string)
      expect_json_types('items.*', vacancies_url: :string, open_vacancies: :int, url: :string,
                        alternate_url: :string, id: :string, name: :string)

    end

    it 'get all employers with params: text, area' do
      company_name ='Новые Облачные Технологии'
      area_id = @expected_countries.get_expected_countries_by_name('Россия')['id']
      get '/employers', {params: {text: company_name,
                                  area: area_id}}
      expect_status 200
      expect_json('items.0.name', company_name)
      expect_json('found', 1)
      check_paging 0, 20, 1
      expect_json_types('items.0.logo_urls', '90': :string)
      expect_json_types('items.0', vacancies_url: :string, open_vacancies: :int, url: :string,
                        alternate_url: :string, id: :string)
    end

    it 'get all employers with params: text, type, area' do
      company_name ='100 профессий'
      area_id = @expected_countries.get_expected_countries_by_name('Россия')['id']
      get '/employers', {params: {text: company_name, type: 'agency',
                                  # , only_with_vacancies: 123, page: 'a', per_page: 3000,
                                  area: area_id
      }}
      expect_status 200
      expect_json('items.0.name', company_name)
      expect_json('found', 1)
      check_paging 0, 20, 1
      expect_json_types('items.0.logo_urls', '90': :string)
      expect_json_types('items.0', vacancies_url: :string, open_vacancies: :int, url: :string,
                        alternate_url: :string, id: :string)
    end

    it 'get all employers with params: type, area, only_with_vacancies' do
      area_id = @expected_countries.get_expected_countries_by_name('Россия')['id']
      get '/employers', {params: {type: 'private_recruiter', only_with_vacancies: true,
                                  area: area_id
      }}
      expect_status 200
      expect_json('items.*', open_vacancies: -> (open_vacancies){ expect(open_vacancies).to be >= 1 })
      expect_json_types(found: :int, page: :int, per_page: :int)
      expect_json_types('items.*.logo_urls', '90': :string)
      expect_json_types('items.*', vacancies_url: :string, open_vacancies: :int, url: :string,
                        alternate_url: :string, id: :string, name: :string)
    end

    it 'get all employers with incorrect value for param area' do
      area_id = 'qwe123@#'
      get '/employers', {params: {type: 'private_recruiter', only_with_vacancies: true,
                                  area: area_id
      }}
      expect_status 400
      check_error_message 'area', 'Invalid area format'
    end


  end

  context 'check employers by id endpoint' do

  end

  private

  def check_paging(page, per_page, pages)
    expect_json('page', page)
    expect_json('per_page', per_page)
    expect_json('pages', pages)
  end

  def check_error_message(invalid_param, description)
    expect_json(bad_argument: invalid_param, description: description)
    expect_json_sizes(errors: 1, bad_arguments: 1)
    expect_json('errors.0', type: 'bad_argument', value: invalid_param)
    expect_json('bad_arguments.0', description: description, name: invalid_param)
  end

end
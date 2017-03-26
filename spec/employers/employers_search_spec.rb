require 'airborne'
require 'spec_helper'


describe 'employers' do

  before(:all) do
    @areas = Area.new 'areas.json', 'countries.json'
  end

  context 'check employers endpoint' do

    it 'get all employers without params' do
      get Employer.get_employers_url
      expect_status 200
      expect_json_types(Employer.get_expected_types_for_employers)
      expect_json_types('items.*', Employer.get_expected_types_for_employer)
    end

    it 'get all employers with params: text, area' do
      company_name ='Новые Облачные Технологии'
      area_id = @areas.get_expected_countries_by_name('Россия')['id']
      expected_count_for_employers = 1
      get Employer.get_employers_url, {params: {text: company_name,
                                  area: area_id}}
      expect_status 200
      expect_json('items.0.name', company_name)
      expect_json('found', expected_count_for_employers)
      expect_json_types(Employer.get_expected_types_for_employers)
      expect_json_types('items.*', Employer.get_expected_types_for_employer)
    end

    it 'get all employers with params: text, type, area' do
      company_name ='100 профессий'
      type_for_search = 'agency'
      expected_count_for_employers = 1
      area_id = @areas.get_expected_countries_by_name('Россия')['id']
      get Employer.get_employers_url, {params: {text: company_name, type: type_for_search,
                                  area: area_id
      }}
      expect_status 200
      expect_json('items.0.name', company_name)
      expect_json('found', expected_count_for_employers)
      expect_json_types(Employer.get_expected_types_for_employers)
      expect_json_types('items.*', Employer.get_expected_types_for_employer)
    end

    it 'get all employers with params: type, area, only_with_vacancies' do
      area_id = @areas.get_expected_countries_by_name('Россия')['id']
      get Employer.get_employers_url, {params: {type: 'private_recruiter', only_with_vacancies: true,
                                  area: area_id
      }}
      expect_status 200
      expect_json('items.*', open_vacancies: -> (open_vacancies){ expect(open_vacancies).to be >= 1 })
      expect_json_types(Employer.get_expected_types_for_employers)
      expect_json_types('items.*', Employer.get_expected_types_for_employer)
    end

    it 'get all employers with incorrect value for param area' do
      area_id = 'qwe123@#'
      get Employer.get_employers_url, {params: {type: 'private_recruiter', only_with_vacancies: true,
                                  area: area_id
      }}
      expect_status 400
      check_error_message 'area', 'Invalid area format'
    end


  end

  context 'check employers by id endpoint' do

  end

  private

  def check_error_message(invalid_param, description)
    expect_json(bad_argument: invalid_param, description: description)
    expect_json_sizes(errors: 1, bad_arguments: 1)
    expect_json('errors.0', type: 'bad_argument', value: invalid_param)
    expect_json('bad_arguments.0', description: description, name: invalid_param)
  end

end
require 'airborne'
require 'spec_helper'


describe 'vacancies' do

  before(:all) do
    @areas = Area.new 'areas.json', 'countries.json'
  end

  context 'check vacancies endpoint' do

    it 'get all vacancies without params', :severity => :critical, :testId => 13 do |e|
      e.step 'GET '+Vacancy.get_employers_url do
        get Vacancy.get_employers_url
      end
      e.step 'check status and body' do
        expect_status 200
        expect_json_types(Vacancy.get_expected_types_for_vacancies)
        expect_json_types('items.*', Vacancy.get_expected_types_for_vacancy)
      end
    end

    it 'get all vacancies with params: text(name, company_name), area, vacancy_search_fields(default)',
       :severity => :critical, :testId => 14 do |e|
      company_name ='Новые Облачные Технологии'
      vacancy ='QA Automation Engineer'
      area_id = @areas.get_area_id_by_name 'Россия', 'Санкт-Петербург'
      text_for_search = 'NAME:"'+vacancy+'" and COMPANY_NAME:'+company_name
      expected_count_for_vacancies = 2
      params = {text: text_for_search, area: area_id}
      e.step 'GET '+Vacancy.get_employers_url + ' params: '+params.to_s do
        get Vacancy.get_employers_url, {params: params}
      end
      e.step 'check status and body' do
        expect_status 200
        expect_json('found', expected_count_for_vacancies)
        expect_json('items.*', name: -> (name) { expect(name).to include vacancy })

        expect_json_types(Vacancy.get_expected_types_for_vacancies)
        expect_json_types('items.*', Vacancy.get_expected_types_for_vacancy)
      end
    end

    it 'get all vacancies with params: text(name, DESCRIPTION), area', :severity => :critical, :testId => 15  do |e|
      description_1 = 'Python'
      description_2 = 'Ruby'
      description ='('+description_1+' OR '+description_2+')'
      vacancy ='QA Automation Engineer'
      area_id = @areas.get_area_id_by_name 'Россия', 'Санкт-Петербург'
      text_for_search = 'NAME:"' + vacancy + '" and DESCRIPTION:' + description
      params = {text: text_for_search, area: area_id}
      e.step 'GET '+Vacancy.get_employers_url + ' params: '+params.to_s do
        get Vacancy.get_employers_url, {params: params}
      end
      e.step 'check status and body' do
        expect_status 200
        expect_json('items.*', name: -> (name) { expect(name).to include vacancy })
        expect_json('items.*.snippet', requirement: -> (requirement) { expect(requirement).to match('/'+description_1+'|'+description_2+'/') })

        expect_json_types(Vacancy.get_expected_types_for_vacancies)
        expect_json_types('items.*', Vacancy.get_expected_types_for_vacancy)
      end
    end
  end

end
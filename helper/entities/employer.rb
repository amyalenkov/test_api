class Employer

  def self.get_employers_url
    '/employers'
  end

  def self.get_expected_types_for_employers
    Hash.new found: :int, page: :int, per_page: :int, pages: :int, items: :array_of_objects
  end

  def self.get_expected_types_for_employer
    Hash.new vacancies_url: :string, open_vacancies: :int, url: :string,
             alternate_url: :string, id: :string, name: :string, logo_urls: :string
  end
end
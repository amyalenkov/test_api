class Vacancy

  def self.get_employers_url
    '/vacancies'
  end

  def self.get_expected_types_for_vacancy
    Hash.new(salary: :object_or_null, snippet: :object_or_null, archived: :boolean, premium: :boolean, name: :string,
             area: :object, url: :string, created_at: :string, apply_alternate_url: :string, relations: :array, employer: :object,
             response_letter_required: :boolean, published_at: :string, address: :object, department: :string_or_null,
             alternate_url: :string, type: :object, id: :string)
  end

  def self.get_expected_types_for_vacancies
    Hash.new(clusters: :array_of_objects_or_null, alternate_url: :string, page: :int, per_page: :int, pages: :int, found: :int)
  end

end
class Course < ActiveRecord::Base
  def self.search_for(search_terms)
    search_results = []
    search_results << Course.all.select { |course| course.title.include?(search_terms) || course.description.include?(search_terms) }
  end
end
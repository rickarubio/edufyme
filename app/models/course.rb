class Course < ActiveRecord::Base
  belongs_to :school
  belongs_to :category
  has_many :course_teachers
  has_many :course_users
  has_many :teachers, :through => :course_teachers
  has_many :users, :through => :course_users

  def self.search_for(search_terms)
    search_results = []
    search_results << Course.all.select { |course| course.title.include?(search_terms) || course.description.include?(search_terms) }
  end
  
end
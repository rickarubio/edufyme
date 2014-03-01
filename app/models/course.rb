class Course < ActiveRecord::Base
  attr_accessible :school_id, :category_id, :title, :description, :course_url,
    :course_img_url, :start_date, :end_date
  belongs_to :school
  belongs_to :category
  has_many :course_teachers
  has_many :course_users
  has_many :teachers, :through => :course_teachers
  has_many :users, :through => :course_users

  def self.featured
    featured_courses = Course.all.sample(6)
  end

  def self.search_for(search_terms)
    Course.all.select { |course| course.title.downcase.include?(search_terms.downcase) || course.description.downcase.include?(search_terms.downcase) }
  end

  def short_title
    max_title_length = 37
    self.title.slice(0, max_title_length)
  end

end
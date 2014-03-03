class Course < ActiveRecord::Base
  attr_accessible :school_id, :category_id, :title, :description, :course_url,
    :course_img_url, :start_date, :end_date, :short_description
  belongs_to :school
  belongs_to :category
  has_many :course_teachers
  has_many :course_users
  has_many :teachers, :through => :course_teachers
  has_many :users, :through => :course_users

  def self.featured
    featured_courses = Course.all
    instance_courses = []
    9.times { instance_courses << featured_courses.delete_at(rand(featured_courses.length)) }
    instance_courses
  end

  def self.search_for(search_terms)
    Course.all.select { |course| course.title.downcase.include?(search_terms.downcase) || course.description.downcase.include?(search_terms.downcase) }
  end

  def short_title
    max_title_length = 37
    self.title.slice(0, max_title_length)
  end

  def short_teacher_bio
    max_bio_length = 450
    self.description.slice(0, max_bio_length)
  end

  def self.filter(filter_option)
    Course.all.select { |course| course.category.name == filter_option || course.school.name == filter_option }
  end
end
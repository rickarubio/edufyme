class Course < ActiveRecord::Base
  attr_accessible :school_id, :title, :description, :course_url,
    :course_img_url, :start_date, :teachers
  belongs_to :school
  has_many :course_users
  has_many :users, :through => :course_users

  def self.featured
    Course.all.sample(9)
  end

  def self.search_for(search_terms)
    Course.all.select { |course| course.title.downcase.include?(search_terms.downcase) || course.description.downcase.include?(search_terms.downcase) }
  end

  def short_title
    max_title_length = 37
    self.title.slice(0, max_title_length)
  end

  def self.filter(filter_option)
    Course.all.select { |course| course.category.name == filter_option || course.school.name == filter_option }
  end
end
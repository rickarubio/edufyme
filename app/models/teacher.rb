class Teacher < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :teacher_img_url, :teacher_url
  has_many :course_teachers
  has_many :courses, :through => :course_teachers
end
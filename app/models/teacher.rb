class Teacher < ActiveRecord::Base
  has_many :course_teachers
  has_many :courses, :through => :course_teachers
end
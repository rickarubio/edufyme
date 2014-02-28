class CourseTeacher < ActiveRecord::Base
  attr_accessible :teacher_id, :course_id, :starred
  belongs_to :teacher
  belongs_to :course
end
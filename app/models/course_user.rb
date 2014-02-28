class CourseUser < ActiveRecord::Base
  attr_accessible :user_id, :course_id, :starred
  belongs_to :course
  belongs_to :user
end
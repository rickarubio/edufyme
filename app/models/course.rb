class Course < ActiveRecord::Base
  belongs_to :school
  belongs_to :category
  has_many :course_teachers
  has_many :course_users
  has_many :teachers, :through => :course_teachers
  has_many :users, :through => :course_users
end
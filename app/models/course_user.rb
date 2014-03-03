class CourseUser < ActiveRecord::Base
  attr_accessible :user_id, :course_id, :starred, :completed
  belongs_to :course
  belongs_to :user

  def star_course
    self.starred = true
    self.save
  end

  def self.find_starred_by(current_user)
  	CourseUser.where(user_id: current_user.id, starred: true)
  end

  def self.find_completed_by(current_user)
  	CourseUser.where(user_id: current_user.id, completed: true)
  end
end
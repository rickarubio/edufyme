class CourseUser < ActiveRecord::Base
  attr_accessible :user_id, :course_id, :favorited, :completed
  belongs_to :course
  belongs_to :user

  def self.find_favorited_by(current_user)
  	CourseUser.where(user_id: current_user.id, favorited: true)
  end

  def self.find_completed_by(current_user)
  	CourseUser.where(user_id: current_user.id, completed: true)
  end
end
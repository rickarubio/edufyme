class UsersController < ApplicationController
  before_filter :authenticate_user!

  def dashboard
  	@current_courses = current_user.courses
  	@starred_courses = CourseUser.find_starred_by(current_user)
  	@completed_courses = CourseUser.find_completed_by(current_user)
  end
end
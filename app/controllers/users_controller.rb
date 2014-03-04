class UsersController < ApplicationController
  before_filter :authenticate_user!

  def dashboard
    @current_courses = CourseUser.where(user_id: current_user.id, completed: false).map do |course_user|
      Course.find(course_user.course_id)
    end

  	@favorited_courses = CourseUser.find_favorited_by(current_user).map do |course_user|
      Course.find(course_user.course_id)
    end

  	@completed_courses = CourseUser.find_completed_by(current_user).map do |course_user|
      Course.find(course_user.course.id)
    end
  end
end
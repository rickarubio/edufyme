class UserCoursesController < ApplicationController
  before_filter :authenticate_user!

  def create
    user = User.find(params[:user_id].to_i)
    course = Course.find(params[:course_id].to_i)
    user.courses << course
    render json: params
  end

  def destroy
    user = User.find(params[:user_id].to_i)
    course = Course.find(params[:course_id].to_i)
    user.courses.delete(course)
    render json: params
  end
end
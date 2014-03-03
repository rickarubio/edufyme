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

  def update
    if params[:update_action]["starred"] == "true"
      params[:update_action]["starred"] = true
    else
      params[:update_action]["starred"] = false
    end
    starred = {starred: params["update_action"]["starred"]}
    CourseUser.find_by_user_id_and_course_id(params[:user_id].to_i, params[:course_id].to_i).update_attributes(starred)
    render json: params
  end
end
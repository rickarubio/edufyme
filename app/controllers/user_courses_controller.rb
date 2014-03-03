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
    if params[:update_action]["favorited"] == "true"
      params[:update_action]["favorited"] = true
    else
      params[:update_action]["favorited"] = false
    end
    # binding.pry
    favorited = {favorited: params["update_action"]["favorited"]}
    # p params
    CourseUser.find_by_user_id_and_course_id(params[:user_id].to_i, params[:course_id].to_i).update_attributes(favorited)
    render json: params
  end
end
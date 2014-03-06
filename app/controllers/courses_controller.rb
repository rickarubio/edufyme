class CoursesController < ApplicationController

  def index
    @courses = Course.featured
    if request.xhr?
      @schools = @courses.map { |course| course.school.name }
      render :json => [@courses, @schools]
    end
  end

  def show
    @course = Course.find(params[:id])
    respond_to do |format|
      format.json {render :json => [@course, School.find(@course.school_id)]}
    end
  end

  def search
    @courses = Course.search_for(params["terms"])
    render json: @courses
  end

end
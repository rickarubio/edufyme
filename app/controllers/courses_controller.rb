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
      format.json {render :json => @course}
    end
  end

  def search
    @courses = Course.search_for(params[:search])
    render json: @courses
  end

  def filter
    @courses = Course.filter(params[:filter_options])
    render :search_results
  end
end
class CoursesController < ApplicationController

  def index
    @courses = Course.featured
  end

  def show
    @course = Course.find(params[:id])
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
class CoursesController < ApplicationController

  def index
    @courses = Course.featured
  end

  def search
    @courses = Course.search_for(params[:search])
    render :search_results
  end

end
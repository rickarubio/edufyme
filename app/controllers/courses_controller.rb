class CoursesController < ActionController

  def search
    @courses = Courses.search_for(params[:search])
    render :search_results
  end

end
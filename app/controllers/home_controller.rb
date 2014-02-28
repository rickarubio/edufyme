class HomeController < ApplicationController
  def index
    @courses = Course.featured
  end
end
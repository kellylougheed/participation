class ClassesController < ApplicationController

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end
  
end
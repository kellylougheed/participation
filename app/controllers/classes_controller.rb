class ClassesController < ApplicationController

  def index
    @courses = Course.all
  end

  def create
    @course = Course.create(course_params)
    redirect_to classes_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :user_id)
  end
  
end
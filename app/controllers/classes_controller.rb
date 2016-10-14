class ClassesController < ApplicationController

  def index
    @courses = Course.all
    @new_course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    @course.save
    redirect_to classes_path
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
  
end
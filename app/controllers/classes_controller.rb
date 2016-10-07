class ClassesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    Course.create(course_params)
    redirect_to classes_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :user_id)
  end
  
end
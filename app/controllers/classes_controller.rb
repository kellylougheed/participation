class ClassesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show, :destroy]

  def index
    @new_course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.user = current_user
    @course.save
    redirect_to classes_path
  end

  def show
    @course = current_course
    @new_student = Student.new
  end

  def destroy
    @course = current_course
    @course.destroy
    redirect_to classes_path
  end

  private

  def require_authorized_for_current_course
    if current_course.user != current_user
      render text: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :starting_points, :total_points)
  end
  
end
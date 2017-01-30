class ClassesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:edit, :update, :show, :reset_all, :destroy]

  def index
    @new_course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.user = current_user
    if @course.valid?
      @course.save
      redirect_to classes_path
    else
      redirect_to classes_path
      flash[:alert] = 'Please enter a valid class name and numeric point values.'
    end
  end

  def edit
    @course = current_course
  end

  def update
    @course = current_course
    if @course.update_attributes(course_params)
      flash[:notice] = 'The class was successfully updated.'
      redirect_to class_path(@course)
    else
      redirect_to class_path(@course)
      flash[:alert] = 'The class could not be updated because of an invalid class name or point values. Please try again.'
    end
  end

  def show
    @course = current_course
    @new_student = Student.new
  end

  def reset_all
    @course = Course.find(params[:class_id])
    if @course.user != current_user
      render text: 'Unauthorized', status: :unauthorized
    end
    @all_students = @course.students
    @starting_points = @course.starting_points
    @all_students.update_all(points: @starting_points)
    redirect_to class_path(@course)
  end

  def destroy
    @course = current_course
    @course.destroy
    redirect_to classes_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :starting_points, :total_points)
  end
  
end

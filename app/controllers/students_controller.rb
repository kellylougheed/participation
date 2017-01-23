class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:create]
  before_action :require_authorized_for_current_student, only: [:show, :update, :destroy]

  def create
    @course = Course.find(params[:class_id])
    @course.students.create(student_params.merge(course_id: @course.id, points: @course.starting_points))
    redirect_to class_path(@course)
  end

  def show
    @student = current_student
    @course = @student.course
    @comment = Comment.new
    @comments = @student.comments
  end

  def edit
    @student = current_student
  end

  def update
    @course = current_student.course
    current_student.update_attributes(student_params)

    redirect_to class_path(@course)
  end

  def destroy
    @student = current_student
    @course = @student.course
    @student.destroy
    redirect_to class_path(@course)
  end

  private

  def require_authorized_for_current_student
    if current_student.course.user != current_user
      render text: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_student
  def current_student
    @current_student ||= Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :points)
  end

end

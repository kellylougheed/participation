class StudentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @course = Course.find(params[:class_id])
    @course.students.create(student_params.merge(course_id: @course.id, points: @course.starting_points))

    redirect_to class_path(@course)
  end

  def show
    @student = Student.find(params[:id])
    @course = @student.course
    @comment = Comment.new
    @comments = @student.comments
  end

  def update
    Student.find(params[:id]).update_attributes(student_params)

    redirect_to class_path(@course)
  end

  def destroy
    @student = Student.find(params[:id])
    @course = @student.course
    if current_user != @course.user
      return render text: 'Not Allowed', status: :forbidden
    end
    @student.destroy
    redirect_to class_path(@course)
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :points)
  end

end
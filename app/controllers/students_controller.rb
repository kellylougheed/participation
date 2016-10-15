class StudentsController < ApplicationController

  def create
    @course = Course.find(params[:class_id])
    @course.students.create(student_params.merge(course_id: @course.id, points: @course.starting_points))

    redirect_to class_path(@course)
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name)
  end

end
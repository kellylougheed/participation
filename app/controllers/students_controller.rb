class StudentsController < ApplicationController

  def create
    @course = Course.find(params[:class_id])
    @course.students.create(student_params.merge(course_id: @course.id, points: @course.starting_points))

    redirect_to class_path(@course)
  end

  def update
    Student.find(params[:id]).update_attributes(student_params)

    redirect_to class_path(@course)
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :points)
  end

end
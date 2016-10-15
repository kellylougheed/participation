class StudentsController < ApplicationController

  def create
    @new_student = Course.find(id).students.create(student_params)
    @student.starting_points = @student.course.starting_points
    @student.save
    redirect_to classes_path
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name)
  end

end
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_student

  def create
    current_student.comments.create(comment_params.merge(student_id: current_student.id))
    redirect_to student_path(current_student)
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy
    redirect_to student_path(current_student)
  end

  private

  def require_authorized_for_current_student
    if current_student.course.user != current_user
      render text: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_student
  def current_student
    @current_student ||= Student.find(params[:student_id])
  end

  def comment_params
    params.require(:comment).permit(:message)
  end

end

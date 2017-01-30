class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_student

  def create
    @comment = current_student.comments.create(comment_params.merge(
      student_id: current_student.id,
      friendly_date: DateTime.now.strftime('%b %e, %Y')))
    if @comment.auto_send == true && @comment.send_comment_email
      redirect_to student_path(current_student)
      flash[:notice] = "Your comment was successfully emailed to #{@comment.student.first_name}."
    else
      flash[:alert] = "There was a problem sending the email. Please check #{@comment.student.first_name}'s email address and try again."
      redirect_to student_path(current_student)
    end
  end

  def destroy
    @comment = current_comment
    @comment.destroy
    redirect_to student_path(current_student)
  end

  def edit
    @comment = current_comment
  end

  def update
    @comment = current_comment
    if @comment.update_attributes(comment_params)
      redirect_to student_path(current_student)
    else
      redirect_to student_path(current_student)
      flash[:alert] = 'The course could not be updated because of invalid text or an invalid date. Please try again.'
    end
  end

  def email_comment
    @student = current_student
    @comment = current_comment
    if !@student.email_address
      redirect_to student_path(current_student)
      flash[:alert] = "There is no email address on file for #{@student.first_name}. Please add one and try again."
    else
      @comment.send_comment_email
      redirect_to student_path(current_student)
      flash[:notice] = "Your comment was successfully emailed to #{@student.first_name}."
    end
  end

  private

  def require_authorized_for_current_student
    if current_student.course.user != current_user
      render text: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_comment
  def current_comment
    if params[:id].nil?
      @current_comment ||= Comment.find(params[:comment_id])
    else
      @current_comment ||= Comment.find(params[:id])
    end
  end

  helper_method :current_student
  def current_student
    @current_student ||= Student.find(params[:student_id])
  end

  def comment_params
    params.require(:comment).permit(:message, :friendly_date, :auto_send)
  end

end

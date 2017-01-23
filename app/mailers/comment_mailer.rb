class CommentMailer < ActionMailer::Base
  default from: "participationappedu@gmail.com"

  def comment_added(comment)
    @comment = comment
    @student = comment.student
    @course = @student.course
    mail(to: @student.email_address,
        subject: "Your #{@course} teacher added a comment about you")
  end
end

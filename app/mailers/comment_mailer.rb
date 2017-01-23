class CommentMailer < ActionMailer::Base
  default from: "participationappedu@gmail.com"

  def comment_added
    mail(to: "",
        subject: "Your teacher added a comment about you")
  end
end

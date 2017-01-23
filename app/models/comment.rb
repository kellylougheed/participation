class Comment < ActiveRecord::Base
  belongs_to :student
  validates :message, presence: true, length: { minimum: 1 }
  validates :friendly_date, presence: true, length: { minimum: 1 }

  def send_comment_email
    CommentMailer.comment_added(self).deliver
  end
end

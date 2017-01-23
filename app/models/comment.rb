class Comment < ActiveRecord::Base
  belongs_to :student
  validates :message, presence: true, length: { minimum: 1 }
  validates :friendly_date, presence: true, length: { minimum: 1 }
  validates :email_address, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_blank: true

  def send_comment_email
    CommentMailer.comment_added(self).deliver
  end
end

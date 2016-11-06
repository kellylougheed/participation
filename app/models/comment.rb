class Comment < ActiveRecord::Base
  belongs_to :student
  validates :message, presence: true
end

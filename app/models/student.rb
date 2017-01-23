class Student < ActiveRecord::Base
  belongs_to :course
  validates :first_name, presence: true, length: { minimum: 1 }
  validates :last_name, presence: true
  validates :email_address, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_blank: true
  has_many :comments
end

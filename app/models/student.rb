class Student < ActiveRecord::Base
  belongs_to :course
  validates :first_name, presence: true, length: { minimum: 1 }
  validates :email_address, email: true, allow_blank: true
  has_many :comments
end

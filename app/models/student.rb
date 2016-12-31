class Student < ActiveRecord::Base
  belongs_to :course
  validates :first_name, presence: true, length: { minimum: 1 }
  validates :last_name, presence: true
  has_many :comments
end

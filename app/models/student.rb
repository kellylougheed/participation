class Student < ActiveRecord::Base
  belongs_to :course
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :comments
end

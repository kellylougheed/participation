class Student < ActiveRecord::Base
  belongs_to :course
  has_many :comments
end

class Course < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, length: { minimum: 1 }
  validates :starting_points, presence: true, numericality: true
  validates :total_points, presence: true, numericality: true
  has_many :students
end

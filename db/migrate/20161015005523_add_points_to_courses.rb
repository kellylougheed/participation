class AddPointsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :starting_points, :integer
    add_column :courses, :total_points, :integer
  end
end

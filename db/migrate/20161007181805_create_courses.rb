class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end

    add_index :courses, :user_id
  end
end

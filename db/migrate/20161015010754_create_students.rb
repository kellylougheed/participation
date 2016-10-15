class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name

      t.integer :course_id
      t.integer :points

      t.timestamps
    end

    add_index :students, :course_id
  end
end

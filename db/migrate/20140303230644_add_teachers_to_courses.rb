class AddTeachersToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :teachers, :string
  end
end

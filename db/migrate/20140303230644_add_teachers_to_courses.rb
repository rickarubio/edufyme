class AddTeachersToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :teachers, :text
  end
end

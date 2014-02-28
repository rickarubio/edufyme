class CreateCourseTeachers < ActiveRecord::Migration
  def change
    create_table :course_teachers do |t|
      t.belongs_to :teacher
      t.belongs_to :course
      t.boolean :starred

      t.timestamps
    end
  end
end

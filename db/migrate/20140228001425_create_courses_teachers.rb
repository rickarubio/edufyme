class CreateCoursesTeachers < ActiveRecord::Migration
  def change
    create_table :courses_teachers do |t|
      t.belongs_to :teacher
      t.belongs_to :course
      t.boolean :starred

      t.timestamps
    end
  end
end

class CreateCourseUsers < ActiveRecord::Migration
  def change
    create_table :course_users do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.boolean :starred, default: false

      t.timestamps
    end
  end
end

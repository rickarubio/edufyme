class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.belongs_to :school
      t.belongs_to :category
      t.string :title
      t.text :description
      t.string :course_url
      t.string :course_img_url
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end

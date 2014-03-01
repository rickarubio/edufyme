class AddCompletenessToCourseUsers < ActiveRecord::Migration
  def change
    add_column :course_users, :completed, :boolean, default: :false
  end
end

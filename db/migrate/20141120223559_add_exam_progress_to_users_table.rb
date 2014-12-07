class AddExamProgressToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :exam_progress, :string
  end
end

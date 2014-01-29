class AddOptionsToUserModel < ActiveRecord::Migration
  def change
    add_column :users, :work_at_height, :boolean, default: false
    add_column :users, :scaffolder, :boolean, default: false
    add_column :users, :ground_worker, :boolean, default: false
    add_column :users, :operate_machinery, :boolean, default: false
    add_column :users, :lift_loads, :boolean, default: false
  end
end

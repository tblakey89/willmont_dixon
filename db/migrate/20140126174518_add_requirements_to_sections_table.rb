class AddRequirementsToSectionsTable < ActiveRecord::Migration
  def change
    add_column :sections, :work_at_height, :boolean, default: false
    add_column :sections, :scaffolder, :boolean, default: false
    add_column :sections, :ground_workder, :boolean, default: false
    add_column :sections, :operate_machinery, :boolean, default: false
    add_column :sections, :lift_loads, :boolean, default: false
    add_column :sections, :young, :boolean, default: false
    add_column :sections, :supervisor, :boolean, default: false
  end
end

class RenameGroundWorkderColumn < ActiveRecord::Migration
  def change
    rename_column :sections, :ground_workder, :ground_worker
  end
end

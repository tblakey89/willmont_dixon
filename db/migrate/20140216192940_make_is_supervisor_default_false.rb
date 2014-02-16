class MakeIsSupervisorDefaultFalse < ActiveRecord::Migration
  def change
    change_column :users, :is_supervisor, :boolean, default: false
  end
end

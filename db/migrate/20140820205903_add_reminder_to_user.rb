class AddReminderToUser < ActiveRecord::Migration
  def change
    add_column :users, :reminder, :boolean
  end
end

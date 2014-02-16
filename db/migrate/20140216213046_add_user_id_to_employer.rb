class AddUserIdToEmployer < ActiveRecord::Migration
  def change
    add_column :employers, :user_id, :integer
  end
end

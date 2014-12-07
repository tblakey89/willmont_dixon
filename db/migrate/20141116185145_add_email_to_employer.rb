class AddEmailToEmployer < ActiveRecord::Migration
  def change
    add_column :employers, :email, :string
  end
end

class ChangeColumnNameNameEmployer < ActiveRecord::Migration
  def change
    rename_column :employers, :name, :company_name
  end
end

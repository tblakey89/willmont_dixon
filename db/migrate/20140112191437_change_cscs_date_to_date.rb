class ChangeCscsDateToDate < ActiveRecord::Migration
  def change
    change_column :users, :cscs_expiry_date, :date
  end
end

class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :name
      t.string :contact_number
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :region
      t.string :postal_code
      t.timestamps
    end
  end
end

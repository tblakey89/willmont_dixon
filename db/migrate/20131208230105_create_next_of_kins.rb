class CreateNextOfKins < ActiveRecord::Migration
  def change
    create_table :next_of_kins do |t|
      t.string :first_name
      t.string :last_name
      t.string :relationship
      t.string :contact_number
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :postcode
      t.integer :user_id
      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.datetime :last_sign_in
      t.integer :role
      t.string :job
      t.boolean :health_issues
      t.string :cscs_number
      t.datetime :cscs_expiry_date
      t.date :date_of_birth
      t.boolean :is_supervisor
      t.string :national_insurance
      t.date :completed_pre_enrolment
      t.date :pre_enrolment_due
      t.string :contact_number
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :postcode
      t.timestamps
    end
  end
end

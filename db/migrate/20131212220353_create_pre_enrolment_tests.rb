class CreatePreEnrolmentTests < ActiveRecord::Migration
  def change
    create_table :pre_enrolment_tests do |t|
      t.string :name
      t.timestamps
    end
  end
end

class AddTestIdToSections < ActiveRecord::Migration
  def change
    add_column :sections, :pre_enrolment_test_id, :integer
  end
end

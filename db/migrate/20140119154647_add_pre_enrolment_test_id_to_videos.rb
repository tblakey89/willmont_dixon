class AddPreEnrolmentTestIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :pre_enrolment_test_id, :integer
  end
end

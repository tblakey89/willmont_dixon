class ActuallyAddVideoIdToQuestions < ActiveRecord::Migration
  def change
    remove_column :sections, :video_id
    add_column :questions, :video_id, :integer
  end
end

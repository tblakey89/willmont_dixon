class AddVideoIdToQuestions < ActiveRecord::Migration
  def change
    add_column :sections, :video_id, :integer
  end
end

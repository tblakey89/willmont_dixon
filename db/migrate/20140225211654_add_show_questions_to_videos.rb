class AddShowQuestionsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :show_questions, :integer
  end
end

class RenameQuestionsToAnswersOnQuestionsTable < ActiveRecord::Migration
  def change
    rename_column :questions, :question1, :answer1
    rename_column :questions, :question2, :answer2
    rename_column :questions, :question3, :answer3
    rename_column :questions, :question4, :answer4
  end
end

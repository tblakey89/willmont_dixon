class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.string :question1
      t.string :question2
      t.string :question3
      t.string :question4
      t.integer :answer
      t.integer :order
      t.integer :section_id
      t.integer :pre_enrolment_test_id
      t.timestamps
    end
  end
end

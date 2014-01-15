class CreateDisciplinaryCards < ActiveRecord::Migration
  def change
    create_table :disciplinary_cards do |t|
      t.integer :user_id
      t.string :location
      t.string :reason
      t.string :type
      t.timestamps
    end
  end
end

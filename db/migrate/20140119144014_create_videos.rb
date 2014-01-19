class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.integer :order
      t.integer :section_id
      t.timestamps
    end
  end
end

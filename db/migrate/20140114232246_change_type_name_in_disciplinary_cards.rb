class ChangeTypeNameInDisciplinaryCards < ActiveRecord::Migration
  def change
    rename_column :disciplinary_cards, :type, :colour
  end
end

class AddEditedByToWikis < ActiveRecord::Migration
  def change
    add_reference :wikis, :edited_by
    add_index :wikis, :edited_by
  end
end

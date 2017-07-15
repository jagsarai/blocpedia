class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :user_id
      t.integer :wiki_id
    end

    add_index :users, :id, unique: true
    add_index :wikis, :id, unique: true
    add_index :collaborations, :id, unique: true
    add_index :collaborations, :user_id
    add_index :collaborations, :wiki_id
  end
end

class AddAncestryToNotepad < ActiveRecord::Migration[5.1]
  def change
    add_column :notepads, :ancestry, :string
    add_index :notepads, :ancestry
  end
end

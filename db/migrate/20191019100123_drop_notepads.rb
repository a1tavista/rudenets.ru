class DropNotepads < ActiveRecord::Migration[5.2]
  def change
    drop_table :notepad_categories
    drop_table :notepads
  end
end

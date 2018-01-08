class CreateNotepads < ActiveRecord::Migration[5.1]
  def change
    create_table :notepads do |t|
      t.string :name
      t.string :text, default: ""
      t.references :notepad_category, index: true
      t.boolean :is_current
      t.timestamps
    end
  end
end

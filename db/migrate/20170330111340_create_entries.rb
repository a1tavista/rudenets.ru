class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.belongs_to :taxonomy, polymorphic: true
      t.boolean :published
      t.datetime :published_at
      t.timestamps
    end
  end
end

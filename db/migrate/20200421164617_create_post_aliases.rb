class CreatePostAliases < ActiveRecord::Migration[5.2]
  def change
    create_table :post_aliases do |t|
      t.string :slug, index: true, null: false
      t.belongs_to :publication, index: true

      t.timestamps
    end
  end
end

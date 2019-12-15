class AddPreviewHashToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :preview_hash, :string
  end
end

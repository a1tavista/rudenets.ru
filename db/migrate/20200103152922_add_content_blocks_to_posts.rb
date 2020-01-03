class AddContentBlocksToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :content_blocks, :jsonb
  end
end

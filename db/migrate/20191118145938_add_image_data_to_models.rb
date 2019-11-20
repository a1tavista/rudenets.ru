class AddImageDataToModels < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :image_data, :jsonb
    add_column :posts, :cover_image_data, :jsonb
    add_column :posts, :preview_image_data, :jsonb
    add_column :images, :image_data, :jsonb
  end
end

class RemoveOldFieldsForImagesFromEntities < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :file, :string
    remove_column :posts, :cover_img, :string
    remove_column :posts, :preview, :string
    remove_column :links, :image, :string
  end
end

class ChangeFieldNamesForLink < ActiveRecord::Migration[5.0]
  def change
    rename_column :links, :og_title, :title
    rename_column :links, :og_type, :site_name
    remove_column :links, :og_url, :string
    rename_column :links, :og_description, :description
    rename_column :links, :og_images, :image
  end
end

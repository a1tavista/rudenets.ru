class AddCustomCssToPublicationsAndPages < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :custom_css, :string
    add_column :pages, :custom_css, :string
    remove_column :pages, :content, :string
  end
end

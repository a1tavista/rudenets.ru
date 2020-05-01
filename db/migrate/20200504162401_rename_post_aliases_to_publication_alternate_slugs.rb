class RenamePostAliasesToPublicationAlternateSlugs < ActiveRecord::Migration[5.2]
  def change
    rename_table :post_aliases, :publication_alternate_slugs
  end
end

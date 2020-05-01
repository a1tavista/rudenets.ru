class AddContentBlocksToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :content_blocks, :jsonb, null: false, default: []
    add_column :pages, :html_content, :string
  end
end

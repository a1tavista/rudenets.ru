class RenamePrerenderedContentToHtmlContent < ActiveRecord::Migration[5.2]
  def change
    rename_column :publications, :prerendered_content, :html_content
  end
end

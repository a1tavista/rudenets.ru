class AddPrerenderedContentToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :prerendered_content, :text
  end
end

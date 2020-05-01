class DropOldTables < ActiveRecord::Migration[5.2]
  def up
    [:friendly_id_slugs, :entries, :delayed_jobs, :links, :posts, :versions, :comments]
      .each { |table_name| drop_table table_name }
  end
end

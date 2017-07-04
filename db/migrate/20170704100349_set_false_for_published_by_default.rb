class SetFalseForPublishedByDefault < ActiveRecord::Migration[5.1]
  def up
    change_column :entries, :published, :boolean, default: false
    ActiveRecord::Base.connection.execute <<~SQL
      UPDATE "entries" SET "published" = false WHERE "published" IS NULL
    SQL
  end
end

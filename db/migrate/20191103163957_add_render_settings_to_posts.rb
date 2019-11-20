class AddRenderSettingsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :render_settings, :jsonb, null: false, default: {}
  end
end

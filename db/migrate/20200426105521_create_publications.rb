class CreatePublications < ActiveRecord::Migration[5.2]
  def change
    create_table :publications do |t|
      t.string :type, null: false

      t.string :slug

      t.string :title
      t.string :abstract

      t.string :source_name
      t.string :source_url

      t.jsonb :publication_data

      t.jsonb :cover_image_data
      t.jsonb :preview_image_data
      t.jsonb :preview_access_hash

      t.datetime :published_at, index: true
      t.datetime :presented_at, index: true
      t.boolean :featured, null: false, default: false

      t.jsonb :content_blocks, null: false, default: []
      t.string :prerendered_content

      t.integer :reactions_count, index: true, null: false, default: 0
      t.integer :follows_count, index: true, null: false, default: 0

      t.jsonb :meta_data, null: false, default: {}
      t.jsonb :render_settings, null: false, default: {}
      t.jsonb :seo_settings, null: false, default: {}

      t.timestamps
    end
  end
end

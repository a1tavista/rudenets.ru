# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_26_105521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "comments", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "entries", id: :serial, force: :cascade do |t|
    t.string "taxonomy_type"
    t.integer "taxonomy_id"
    t.boolean "published", default: false
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["taxonomy_type", "taxonomy_id"], name: "index_entries_on_taxonomy_type_and_taxonomy_id"
  end

  create_table "event_store_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "event_type", null: false
    t.binary "metadata"
    t.binary "data", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_on_created_at"
    t.index ["event_type"], name: "index_event_store_events_on_event_type"
  end

  create_table "event_store_events_in_streams", id: :serial, force: :cascade do |t|
    t.string "stream", null: false
    t.integer "position"
    t.uuid "event_id", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_in_streams_on_created_at"
    t.index ["stream", "event_id"], name: "index_event_store_events_in_streams_on_stream_and_event_id", unique: true
    t.index ["stream", "position"], name: "index_event_store_events_in_streams_on_stream_and_position", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "images", id: :serial, force: :cascade do |t|
    t.string "imageable_type"
    t.integer "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "image_data"
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "links", id: :serial, force: :cascade do |t|
    t.string "url", null: false
    t.string "summary"
    t.string "title"
    t.string "site_name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "follows_count", default: 0, null: false
    t.jsonb "image_data"
  end

  create_table "pages", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.string "content"
  end

  create_table "post_aliases", force: :cascade do |t|
    t.string "slug", null: false
    t.bigint "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_post_aliases_on_publication_id"
    t.index ["slug"], name: "index_post_aliases_on_slug"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "summary"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.boolean "featured", default: false, null: false
    t.jsonb "render_settings", default: {}, null: false
    t.jsonb "cover_image_data"
    t.jsonb "preview_image_data"
    t.string "preview_hash"
    t.jsonb "content_blocks"
    t.text "prerendered_content"
    t.integer "reading_time"
  end

  create_table "publications", force: :cascade do |t|
    t.string "type", null: false
    t.string "slug"
    t.string "title"
    t.string "abstract"
    t.string "source_name"
    t.string "source_url"
    t.jsonb "publication_data"
    t.jsonb "cover_image_data"
    t.jsonb "preview_image_data"
    t.jsonb "preview_access_hash"
    t.datetime "published_at"
    t.datetime "presented_at"
    t.boolean "featured", default: false, null: false
    t.jsonb "content_blocks", default: [], null: false
    t.string "prerendered_content"
    t.integer "reactions_count", default: 0, null: false
    t.integer "follows_count", default: 0, null: false
    t.jsonb "meta_data", default: {}, null: false
    t.jsonb "render_settings", default: {}, null: false
    t.jsonb "seo_settings", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follows_count"], name: "index_publications_on_follows_count"
    t.index ["presented_at"], name: "index_publications_on_presented_at"
    t.index ["published_at"], name: "index_publications_on_published_at"
    t.index ["reactions_count"], name: "index_publications_on_reactions_count"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end

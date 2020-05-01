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

ActiveRecord::Schema.define(version: 2020_05_19_152137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

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

  create_table "images", id: :serial, force: :cascade do |t|
    t.string "imageable_type"
    t.integer "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "image_data"
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.jsonb "content_blocks", default: [], null: false
    t.string "html_content"
    t.string "custom_css"
  end

  create_table "publication_alternate_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.bigint "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_publication_alternate_slugs_on_publication_id"
    t.index ["slug"], name: "index_publication_alternate_slugs_on_slug"
  end

  create_table "publication_reactions", force: :cascade do |t|
    t.bigint "publication_id"
    t.string "username"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id", "username"], name: "index_publication_reactions_on_publication_id_and_username"
    t.index ["publication_id"], name: "index_publication_reactions_on_publication_id"
    t.index ["username"], name: "index_publication_reactions_on_username"
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
    t.string "html_content"
    t.integer "reactions_count", default: 0, null: false
    t.integer "follows_count", default: 0, null: false
    t.jsonb "meta_data", default: {}, null: false
    t.jsonb "render_settings", default: {}, null: false
    t.jsonb "seo_settings", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "custom_css"
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

  add_foreign_key "publication_reactions", "publications"
end

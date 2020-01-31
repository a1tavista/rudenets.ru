require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/s3"

if ENV.fetch("ENABLE_S3", false)
  store = Shrine::Storage::S3.new(
    bucket: ENV["S3_BUCKET_NAME"],
    public: true,
    access_key_id: ENV["S3_KEY"],
    secret_access_key: ENV["S3_SECRET"],
    region: ENV["S3_REGION"],
  )
end
store ||= Shrine::Storage::FileSystem.new("public", prefix: "uploads/store")

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
  store: store,
}

Shrine.plugin :model
Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :derivatives
Shrine.plugin :store_dimensions
Shrine.plugin :determine_mime_type, analyzer: :marcel

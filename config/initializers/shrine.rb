require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/s3"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
  store: Shrine::Storage::S3.new(
    bucket: ENV.fetch('S3_BUCKET_NAME'), # required
    access_key_id: ENV.fetch('S3_KEY', ''),
    secret_access_key: ENV.fetch('S3_SECRET', ''),
    region: ENV.fetch('S3_REGION'),
  )
}

Shrine.plugin :model
Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :derivatives

module CarrierwaveShrineSynchronization
  def self.included(model)
    model.before_save do
      self.class.uploaders.each_key do |name|
        write_shrine_data(name) if changes.key?(name)
      end
    end
  end

  def write_shrine_data(name)
    name_mapping = self.class::SHRINE_CARRIERWAVE_MAPPING if self.class.const_defined?("SHRINE_CARRIERWAVE_MAPPING")
    attacher_name = name_mapping.present? ? name_mapping[name] : name

    uploader = send(name)
    attacher = Shrine::Attacher.from_model(self, attacher_name)

    if read_attribute(name).present?
      attacher.set shrine_file(uploader)

      uploader.versions.each do |version_name, version|
        attacher.merge_derivatives(version_name => shrine_file(version))
      end
    else
      attacher.set nil
    end
  end

  private

  def shrine_file(uploader)
    name     = uploader.mounted_as
    filename = read_attribute(name)
    path     = uploader.store_path(filename)

    Shrine.uploaded_file(
      storage:  :store,
      id:       path,
      metadata: { "filename" => filename },
    )
  end
end

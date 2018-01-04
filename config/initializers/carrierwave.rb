CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws' # required
  config.fog_credentials = {
      provider: 'AWS', # required
      aws_access_key_id: ENV.fetch('S3_KEY', ''), # required
      aws_secret_access_key: ENV.fetch('S3_SECRET', ''), # required
      region: ENV['S3_REGION'], # optional, defaults to 'us-east-1'
      # host: ENV['S3_ASSET_URL'], # optional, defaults to nil
  }
  config.fog_directory = ENV['S3_BUCKET_NAME']
  # config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
end

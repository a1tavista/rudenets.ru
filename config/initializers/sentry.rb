if ENV['SENTRY_URL'].present?
  package = JSON.parse(File.read(Rails.root.join('package.json')))
  Raven.configure do |config|
    config.dsn = ENV['SENTRY_URL']
    config.environments = ['production']
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
    config.release = package['version']
  end
end

if Rails.env.production?
  IMGKit.configure do |config|
    config.wkhtmltoimage = Rails.root.join('bin', 'wkhtmltopdf').to_s
  end
end

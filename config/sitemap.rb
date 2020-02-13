# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://#{ENV.fetch('APPLICATION_HOST')}"
SitemapGenerator::Sitemap.create {}

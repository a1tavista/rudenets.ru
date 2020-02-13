module SeoHandlers
  class UpdateSitemap < BaseHandler
    def handle_event
      SitemapGenerator::Sitemap.create(sitemaps_path: 'data', default_host: "https://#{ENV.fetch('APPLICATION_HOST')}") do
        add(root_path)
        add(page_path('about'))
        add(posts_path)
        add(links_path)
        Post.published.find_each { |post| add(post_path(post), lastmod: post.updated_at) }
      end
      SitemapGenerator::Sitemap.ping_search_engines if Rails.env.production?
    end
  end
end

namespace :migrate do
  task publications: :environment do
    Post.find_each do |post|
      Publication::Post.create(
        slug: post.slug,
        title: post.title,
        abstract: post.summary,
        source_name: nil,
        source_url: nil,
        publication_data: {},
        cover_image_data: post.cover_image_data,
        preview_image_data: post.preview_image_data,
        preview_access_hash: post.preview_hash,
        published_at: post.entry.published_at,
        presented_at: post.entry.published_at,
        featured: post.featured,
        content_blocks: post.content_blocks,
        prerendered_content: post.prerendered_content,
        reactions_count: 0,
        follows_count: 0,
        meta_data: {reading_time: post.reading_time},
        render_settings: post.render_settings,
        seo_settings: {},
        created_at: post.created_at,
        updated_at: post.updated_at,
      )
    end

    Link.find_each do |link|
      blocks = [{type: "markdown", value: link.summary}]

      Publication::Link.create(
        slug: nil,
        title: link.title,
        abstract: link.description,
        source_name: link.site_name,
        source_url: link.url,
        publication_data: {},
        cover_image_data: link.image_data,
        preview_image_data: nil,
        preview_access_hash: nil,
        published_at: link.entry.published_at,
        presented_at: link.entry.published_at,
        featured: false,
        content_blocks: blocks,
        prerendered_content: Kramdown::Document.new(blocks.first[:value] || "", TextHelper::PARSER_OPTIONS).to_custom,
        reactions_count: 0,
        follows_count: link.follows_count,
        meta_data: {},
        render_settings: {},
        seo_settings: {},
        created_at: link.created_at,
        updated_at: link.updated_at,
      )
    end
  end
end

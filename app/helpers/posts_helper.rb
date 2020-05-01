module PostsHelper
  DEFAULT_PREVIEW_RENDER_SETTINGS = {
    'background-size': "cover",
    'background-position': "center center",
    'background-repeat': "no-repeat",
  }.freeze

  def styles_for_post_preview(post)
    cover_url = post.cover_image(:shaped)&.url || post.cover_image&.url
    return if cover_url.nil?

    settings = DEFAULT_PREVIEW_RENDER_SETTINGS.stringify_keys
      .merge(post.render_settings.fetch("preview", {}))
      .merge('background-image': "url(#{cover_url})")
    to_styles(settings)
  end

  def styles_for_page_preview(page)
    cover_url = page.cover_image&.url

    return if cover_url.nil?
  end

  private

  def to_styles(settings)
    settings.map { |p| p.join(":") }.join(";")
  end
end

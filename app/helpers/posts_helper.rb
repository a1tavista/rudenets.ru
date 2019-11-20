module PostsHelper
  DEFAULT_PREVIEW_RENDER_SETTINGS = {
    'background-size': 'cover',
    'background-position': 'center center',
    'background-repeat': 'no-repeat'
  }.freeze

  def cover_url_for(post)
    post.cover_img.shaped.url
  end

  def styles_for_post_preview(post)
    cover_url = post.cover_img.shaped.url

    return if cover_url.nil?
    settings = DEFAULT_PREVIEW_RENDER_SETTINGS.
        merge(post.render_settings.fetch('preview', {})).
        merge('background-image': "url(#{cover_url})")
    to_styles(settings)
  end

  private

  def to_styles(settings)
    settings.map { |p| p.join(':') }.join(';')
  end
end

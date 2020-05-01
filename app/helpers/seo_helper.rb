module SeoHelper
  include ActionView::Helpers::AssetUrlHelper

  def default_tags
    {
      site: "A. Rudenets",
      description: "Маленький уютный блог.",
      keywords: [
        "Андрей Руденец",
        "блог",
        "разработка",
        "программрование",
        "архитектура",
        "рефакторинг",
        "технический долг",
        "рекомендации",
        "юфу",
        "мехмат",
        "ruby",
        "rails",
        "ror",
        "музыка",
        "рецензии",
        "книги",
      ],
      og: {
        title: :title,
        description: :description,
        type: "website",
        url: root_url,
        image: [
          {
            _: image_url("og_cover.png"),
            width: 1200,
            height: 630,
          },
        ],
      },
      twitter: {
        card: "summary",
        site: "@a1tavista",
      },
      reverse: true,
    }
  end

  def post_tags(post)
    default_tags.deep_merge(
      description: post.abstract || nil,
      og: {
        description: post.abstract || "Маленький уютный блог.",
        url: post_url(post),
        image: images_for(post),
      }.compact,
      canonical: post_url(post),
      article: {
        published_time: post.published_at,
        modified_time: post.updated_at,
      }
    ).compact
  end

  private

  def images_for(post)
    [
      image_to_og(post.cover_image),
      image_to_og(post.cover_image(:shaped)),
      image_to_og(post.preview_image),
    ].compact.presence
  end

  def image_to_og(image)
    return if image.nil?

    {_: image.url, width: image.width, height: image.height}
  end
end

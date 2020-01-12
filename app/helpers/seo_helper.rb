module SeoHelper
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
      },
      twitter: {
        card: "summary",
        site: "@a1tavista",
      },
      reverse: true
    }
  end

  def post_tags(post)
    cover_url = post.cover_image(:shaped)&.url || post.cover_image&.url

    default_tags.deep_merge(
      description: post.summary || nil,
      og: {
        description: post.summary || "Маленький уютный блог.",
        url: post_url(post),
        image: [
          ({_: cover_url, width: 1920, height: 900} if cover_url.present?)
        ].compact.presence
      }.compact,
      canonical: post_url(post),
      article: {
        published_time: post.entry.published_at,
        modified_time: post.updated_at,
      }
    ).compact
  end
end

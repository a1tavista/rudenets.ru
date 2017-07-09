module SeoHelper
  def default_tags
    {
      site: 'A. Rudenets',
      description: 'Маленький уютный блог.',
      keywords: [
        'Андрей Руденец',
        'блог',
        'разработка',
        'программрование',
        'юфу',
        'мехмат',
        'жизнь',
        'музыка',
        'рецензии',
        'книги'
      ],
      reverse: true,
      og: {
        title: :title,
        description: :description,
        type: 'website',
        url: root_url
      },
      twitter: {
        card: "summary",
        site: "@AndrewRudenets"
      }
    }
  end

  def post_tags(post)
    {
      description: post.summary || 'Маленький уютный блог.',
      og: {
        description: post.summary || 'Маленький уютный блог.',
        url: post_url(post)
      },
      canonical: post_url(post),
      article: {
        published_time: post.entry.published_at,
        modified_time: post.updated_at
      }
    }
  end
end

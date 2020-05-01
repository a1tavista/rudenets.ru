json.array! @posts do |post|
  json.id post.id
  json.title post.title
  json.abstract post.abstract
  json.updated_at_localized l(post.updated_at)

  json.published post.published_at
  json.published_at_localized safe_l(post.published_at)

  json.cover_image_url do
    json.source post.cover_image&.url
    json.shaped post.cover_image(:shaped)&.url
  end
end

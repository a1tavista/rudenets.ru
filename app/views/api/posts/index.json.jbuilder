json.array! @posts.includes(:entry) do |post|
  json.id post.id
  json.title post.title
  json.summary post.summary
  json.updated_at_localized l(post.updated_at)

  json.cover_image_url do
    json.source post.cover_image&.url
    json.shaped post.cover_image(:shaped)&.url
  end

  json.entry do
    json.published post.entry.published
    json.published_at_localized safe_l(post.entry.published_at)
  end
end

json.id @post.id
json.title @post.title
json.abstract @post.abstract
json.preview_url preview_posts_url(@post.preview_access_hash)
json.content_blocks @post.content_blocks
json.slug @post.slug

json.cover_image_url do
  json.source @post.cover_image&.url
  json.shaped @post.cover_image(:shaped)&.url
end

json.published @post.published_at.present?
json.published_at @post.published_at

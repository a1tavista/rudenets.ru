json.id @post.id
json.title @post.title
json.summary @post.summary
json.text @post.text
json.preview_url preview_posts_url(@post.preview_hash)

json.cover_image_url do
  json.source @post.cover_image&.url
  json.shaped @post.cover_image(:shaped)&.url
end

json.entry do
  json.published @post.entry.published
  json.published_at @post.entry.published_at
end

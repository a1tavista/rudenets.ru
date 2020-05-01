json.array! @channel_posts do |post|
  json.id post.id
  json.title post.title
  json.content_blocks post.content_blocks
  json.updated_at_localized l(post.updated_at)
  json.published post.published_at
  json.published_at_localized safe_l(post.published_at)
end

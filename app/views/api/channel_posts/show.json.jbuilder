json.id @channel_post.id
json.title @channel_post.title
json.content_blocks @channel_post.content_blocks
json.html_content @channel_post.html_content
json.updated_at_localized l(@channel_post.updated_at)
json.published @channel_post.published_at
json.published_at_localized safe_l(@channel_post.published_at)

json.id @link.id
json.source_url @link.source_url
json.title @link.title
json.cover_image @link.cover_image
json.abstract @link.abstract
json.content_blocks link.content_blocks

json.published @link.published_at.present?

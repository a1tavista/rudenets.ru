json.id @post.id
json.title @post.title
json.summary @post.summary
json.text @post.text

json.set! :tag_list do
  json.array! @post.tag_list
end

json.entry do
  json.published @post.entry.published
  json.published_at @post.entry.published_at
end

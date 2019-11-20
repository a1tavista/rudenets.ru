json.id @post.id
json.title @post.title
json.summary @post.summary
json.text @post.text

json.entry do
  json.published @post.entry.published
  json.published_at @post.entry.published_at
end

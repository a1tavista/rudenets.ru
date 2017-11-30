json.array! @posts.includes(:entry) do |post|
  json.id post.id
  json.title post.title
  json.summary post.summary

  json.entry do
    json.published post.entry.published
  end
end

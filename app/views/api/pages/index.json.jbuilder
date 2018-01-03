json.array! @pages do |page|
  json.id page.id
  json.url page.url
  json.title page.title
  json.content page.content
end

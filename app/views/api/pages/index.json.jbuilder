json.array! @pages do |page|
  json.id page.id
  json.url page.url
  json.title page.title
  json.content_blocks page.content_blocks
  json.custom_css page.custom_css
end

json.success @success
json.url @url

if @success
  json.opengraph do
    json.url @og.url
    json.title @og.title
    json.description @og.description
    json.image @og.images[0]
  end
end

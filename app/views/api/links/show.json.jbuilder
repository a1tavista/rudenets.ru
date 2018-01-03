json.id @link.id
json.url @link.url
json.title @link.title
json.image @link.image
json.description @link.description
json.summary @link.summary

json.entry do
  json.published @link.entry.published
end

json.title @opengraph.title
json.url @opengraph.url
json.description @opengraph.description
json.images(@opengraph.images.map! { |image| image.is_a?(OpenStruct) ? image.url : image })
json.site_name @opengraph.try(:site_name)

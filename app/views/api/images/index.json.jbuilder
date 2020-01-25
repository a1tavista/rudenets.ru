json.total @all_images.count
json.total_pages @images.total_pages
json.images @images do |image|
  json.id image.id
  json.optimized_url image.image(:optimized)&.url
  json.original_url image.image.url
end

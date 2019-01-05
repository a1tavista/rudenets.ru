json.total @all_images.count
json.total_pages @images.total_pages
json.images @images do |image|
  json.id image.id
  json.file_url image.file.url
end

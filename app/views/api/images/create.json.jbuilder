json.id @image.id
json.optimized_url @image.image(:optimized)&.url
json.original_url @image.image.url

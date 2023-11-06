json.array! @products do |product|
  json.name product.name
  json.description product.description
  json.id product.id
  json.price product.price
end
json.array! @basket.basket_items.joins(:product).merge(Product.order(:name)) do |basket_item|
  json.name basket_item.product.name
  json.description basket_item.product.description
  json.product_id basket_item.product.id
  json.price basket_item.product.price
  json.amount basket_item.amount
end
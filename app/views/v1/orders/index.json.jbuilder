
json.array! @orders.order(:id) do |order|
  json.id order.id
  json.order_items do
    json.array! order.order_items.joins(:product).merge(Product.order(:name)) do |order_item|
      json.name order_item.product.name
      json.description order_item.product.description
      json.price order_item.price
      json.amount order_item.amount
    end
  end
end
class RemoveItemFromBasket
  def initialize(user, item)
    @basket_item = user.basket&.basket_items&.find_by_product_id(item.product_id)
  end

  def perform
    @basket_item&.destroy
  end
end

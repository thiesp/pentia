class AddItemToBasket
  def initialize(user, item)
    @basket = if user.basket
      user.basket
    else
      user.create_basket
    end
    @basket = user.basket
    @item = item
  end

  def perform
    @item.amount ||= 1
    existing_item = @basket.basket_items.find_by_product_id(@item.product_id)
    if existing_item
      existing_item.amount += @item.amount
      existing_item.save!
    else
      @item.basket = @basket
      @item.save
    end
  end

end
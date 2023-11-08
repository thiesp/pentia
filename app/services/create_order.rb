class CreateOrder
  def initialize(user)
    @user = user
  end

  def perform
    return unless @user.basket
    return unless @user.basket.basket_items.any?
    basket = @user.basket
    Order.transaction do
      order = @user.orders.create!
      basket.basket_items.each do |basket_item|
        order.order_items.create!(amount: basket_item.amount, price: basket_item.product.price, product: basket_item.product)
      end
      basket.destroy!
    end
  end
end
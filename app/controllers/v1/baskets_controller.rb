class V1::BasketsController < V1::ApplicationController
  respond_to :json

  resource_description do
    short 'Basket'
  end

  def_param_group :list_basket_item do
    property :amount, :number
    property :name, String
    property :description, String
    property :price, :decimal
    property :id, :number
  end

  def_param_group :basket_item do
    param :basket_item, Hash do
      param :amount, :number, required: true
      param :product_id, :number, required: true
    end
  end

  def_param_group :remove_basket_item do
    param :basket_item, Hash do
      param :product_id, :number, required: true
    end
  end

  api :GET, 'v1/basket', "List all basket items"
  returns array_of: :list_basket_item, code: :ok, desc: "Array of basket items"
  example "[{\"name\":\"Aerodynamic Linen Car\",\"description\":\"Quae ratione est laboriosam.\",\"product_id\":120,\"price\":\"31.22\",\"amount\":10},{\"name\":\"Sleek Marble Clock\",\"description\":\"Ipsam voluptatibus sint quo.\",\"product_id\":119,\"price\":\"54.55\",\"amount\":42}]"
  def show
    @basket = current_user.basket || Basket.new
  end

  api :PUT, 'v1/basket/add_item', "Add item to basket"
  returns code: :ok, desc: "Success"
  param_group :basket_item
  example "{\"basket_item\":{\"product_id\":230,\"amount\":11}}"
  def add_item
    item = BasketItem.new(basket_item_params)
    AddItemToBasket.new(current_user, item).perform
    head :ok
  end

  api :PUT, 'v1/basket/remove_item', "Remove item from basket"
  returns code: :ok, desc: "Success"
  param_group :remove_basket_item
  example "{\"basket_item\":{\"product_id\":230}}"
  def remove_item
    item = BasketItem.new(basket_item_params)
    RemoveItemFromBasket.new(current_user, item).perform
    head :ok
  end

  api :DELETE, 'v1/basket', "Empty the basket"
  returns code: :ok, desc: "Success"
  def destroy
    current_user.basket&.destroy
    head :ok
  end

  private

  def basket_item_params
    params.require(:basket_item).permit(:amount, :product_id)
  end
end
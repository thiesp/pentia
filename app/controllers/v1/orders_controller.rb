class V1::OrdersController < V1::ApplicationController
  resource_description do
    short 'Orders'
  end

  def_param_group :orders do
    property :id, :number
    property :order_items, array_of: Hash do
      property :name, String
      property :description, String
      property :price, :decimal
      property :amount, :number      
    end
  end

  api :GET, 'v1/orders', "List all orders"
  returns array_of: :orders, code: :ok, desc: "Array of orders"
  def index
    @orders = current_user.orders
  end

  api :POST, 'v1/orders', "Create order from basket"
  returns code: :ok, desc: "Success"
  def create
    CreateOrder.new(current_user).perform
    head :ok
  end
end
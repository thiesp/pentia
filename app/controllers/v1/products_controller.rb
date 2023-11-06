class V1::ProductsController < ApplicationController
  respond_to :json

  resource_description do
    short 'Products'
    formats ['json']
    api_version '1'
  end

  def_param_group :product do
    property :name, String
    property :description, String
    property :price, Float
    property :id, Integer
  end

  api :GET, 'v1/products', "List all products"
  returns array_of: :product, code: :ok, desc: "Array of products"
  example ""
  def index
    @products = Product.order(:name).all
    render :index
  end
end

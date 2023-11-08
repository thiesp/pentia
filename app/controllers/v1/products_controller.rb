class V1::ProductsController < V1::ApplicationController
  resource_description do
    short 'Products'
  end

  def_param_group :product do
    property :name, String
    property :description, String
    property :price, :decimal
    property :id, :number
  end

  api :GET, 'v1/products', "List all products"
  returns array_of: :product, code: :ok, desc: "Array of products"
  example "[{\"name\":\"Enormous Rubber Table\",\"description\":\"Dolorum est labore nam.\",\"id\":2,\"price\":\"34.15\"},{\"name\":\"Ergonomic Wooden Chair\",\"description\":\"Repellendus corporis quam magnam.\",\"id\":9,\"price\":\"90.8\"},{\"name\":\"Gorgeous Linen Pants\",\"description\":\"Eius reprehenderit distinctio esse.\",\"id\":7,\"price\":\"65.23\"},{\"name\":\"Incredible Cotton Car\",\"description\":\"Harum perferendis iusto quo.\",\"id\":6,\"price\":\"75.32\"},{\"name\":\"Intelligent Copper Bench\",\"description\":\"At voluptatem pariatur facere.\",\"id\":3,\"price\":\"26.7\"},{\"name\":\"Mediocre Steel Keyboard\",\"description\":\"Est eos voluptatem ut.\",\"id\":4,\"price\":\"95.88\"},{\"name\":\"Sleek Rubber Bench\",\"description\":\"Eos ducimus aut enim.\",\"id\":1,\"price\":\"78.01\"},{\"name\":\"Small Plastic Bench\",\"description\":\"Aut repellendus officiis error.\",\"id\":10,\"price\":\"23.04\"},{\"name\":\"Small Rubber Shoes\",\"description\":\"Qui temporibus voluptatem nostrum.\",\"id\":8,\"price\":\"29.01\"},{\"name\":\"Synergistic Marble Chair\",\"description\":\"Quas non sit cumque.\",\"id\":5,\"price\":\"72.14\"}]"
  def index
    @products = Product.order(:name).all
    render :index
  end
end

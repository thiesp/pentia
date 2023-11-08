require 'rails_helper'

RSpec.describe "V1::Orders", type: :request do
  let(:user) {FactoryBot.build(:user)}
  before(:each) do 
    user.save!
  end
  let(:headers) { Devise::JWT::TestHelpers.auth_headers({'Api-Key' => Rails.application.credentials.api_key }, user)}

  describe "GET /v1/orders" do
    context "without orders" do
      it "returns an empty array" do
        get v1_orders_path+".json", headers: headers
        expect(response).to have_http_status(200)
        expect(response.body).to eq ("\[\]")
      end
    end

    context "with an order" do
      let(:product) { FactoryBot.create :product }
      let(:order) { FactoryBot.create :order, user: user }
      let!(:order_item) { FactoryBot.create :order_item, order: order, product: product, price: product.price, amount: 43 }
      it "returns array with that order" do
        get v1_orders_path+".json", headers: headers
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body).first).to eq ({"id" => order.id, "order_items" => [{"name" => product.name, "description" => product.description, "price" => order_item.price.to_s, "amount" => 43}]})
      end

      context "with changing price" do
        let!(:old_price) {product.price}
        before :each do
          product.update(price: old_price+15)
        end
        it "returns array with that order where the price remains the old price" do
          expect(product.price).to eq old_price+15
          get v1_orders_path+".json", headers: headers
          expect(response).to have_http_status(200)
          expect(JSON.parse(response.body).first["order_items"].first["price"]).to eq old_price.to_s
        end
      end
    end
  end

  describe "POST /v1/orders" do
    context "with full basket" do
      let(:basket) {FactoryBot.create(:basket,user: user)}
      before :each do
        FactoryBot.create_list(:product,10)
        FactoryBot.create(:basket_item, basket: basket, amount: 10, product: Product.order(:name).first)
        FactoryBot.create(:basket_item, basket: basket, amount: 42, product: Product.order(:name).last)
      end
      it "creates a new order" do
        expect{post v1_orders_path+".json", headers: headers
        }.to change{Order.count}.by(1)
        expect(response).to have_http_status(200)
      end
    end

    context "with empty basket" do
      it "does not create a new order" do
        expect{post v1_orders_path+".json", headers: headers
        }.to_not change{Order.count}
        expect(response).to have_http_status(200)
      end
    end
  end
end
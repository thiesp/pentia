require 'rails_helper'

RSpec.describe "V1::Basket", type: :request do
  let(:user) {FactoryBot.build(:user)}
  before(:each) do 
    user.save!
  end
  let(:headers) { Devise::JWT::TestHelpers.auth_headers({'Api-Key' => Rails.application.credentials.api_key }, user)}

  describe "GET /v1/basket" do
    context "without items" do
      it "returns an empty array" do
        get v1_basket_path+".json", headers: headers
        expect(response).to have_http_status(200)
        expect(response.body).to eq ("\[\]")
      end
    end

    context "with items" do
      let(:basket) {FactoryBot.create(:basket,user:user)}
      before :each do
        FactoryBot.create_list(:product,10)
        FactoryBot.create(:basket_item, basket: basket, amount: 10, product: Product.order(:name).first)
        FactoryBot.create(:basket_item, basket: basket, amount: 42, product: Product.order(:name).last)
      end

      it "lists basket items" do
        get v1_basket_path+".json", headers: headers
        expect(response).to have_http_status(200)
        list = JSON.parse(response.body)
        expect(list.count).to eq 2
        first_product = Product.order(:name).first
        expect(list.first).to eq ({
          "name" => first_product.name, 
          "description" => first_product.description, 
          "product_id" => first_product.id, 
          "price" => first_product.price.to_s,
          "amount" => 10})
      end
    end
  end

  describe "PUT /v1/basket/add_item" do
    let(:product) {FactoryBot.create(:product)}

    it "adds an item to the basket" do
      expect{
        put add_item_v1_basket_path+".json", headers: headers, params: {basket_item: {product_id: product.id, amount: 11}}
      }.to change{BasketItem.count}.by(1)
      expect(response).to have_http_status(200)
    end

    it "does not add unknown products" do
      expect{
        put add_item_v1_basket_path+".json", headers: headers, params: {basket_item: {product_id: product.id+42, amount: 11}}
      }.to change{BasketItem.count}.by(0)
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /v1/basket/remove_item" do
    context "with full basket" do
      let(:product) {FactoryBot.create(:product)}
      let(:second_product) {FactoryBot.create(:product)}
      let(:basket) {FactoryBot.create(:basket, user: user)}
      let!(:basket_item) {FactoryBot.create(:basket_item, basket: basket, product: product, amount: 13)}
      let!(:second_basket_item) {FactoryBot.create(:basket_item, basket: basket, product: second_product, amount: 17)}

      it "remove an item from the basket" do
        expect{
          put remove_item_v1_basket_path+".json", headers: headers, params: {basket_item: {product_id: product.id}}
        }.to change{basket.basket_items.count}.by(-1)
        expect(response).to have_http_status(200)
      end
    end

    context "with empty basket" do
      let(:product) {FactoryBot.create(:product)}

      it "remove an item from the basket" do
        put remove_item_v1_basket_path+".json", headers: headers, params: {basket_item: {product_id: product.id}}
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE /v1/basket" do
    context "with full basket" do
      let(:product) {FactoryBot.create(:product)}
      let(:second_product) {FactoryBot.create(:product)}
      let(:basket) {FactoryBot.create(:basket, user: user)}
      let!(:basket_item) {FactoryBot.create(:basket_item, basket: basket, product: product, amount: 13)}
      let!(:second_basket_item) {FactoryBot.create(:basket_item, basket: basket, product: second_product, amount: 17)}

      it "empties the basket" do
        expect(Basket.count).to eq 1
        delete v1_basket_path+".json", headers: headers
        expect(Basket.count).to eq 0
        expect(response).to have_http_status(200)
      end
    end

    context "without basket" do
      it "answers ok" do
        delete v1_basket_path+".json", headers: headers
        expect(response).to have_http_status(200)
      end
    end
  end
end

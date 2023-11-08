require 'rails_helper'

RSpec.describe "V1::Products", type: :request do
  let(:user) {FactoryBot.build(:user)}
  before(:each) do 
    user.save!
  end
  let(:headers) { Devise::JWT::TestHelpers.auth_headers({'Api-Key' => Rails.application.credentials.api_key }, user)}

  describe "GET /v1/products" do
    context "without products" do
      it "returns an empty array" do
        get v1_products_path+".json", headers: headers
        expect(response).to have_http_status(200)
        expect(response.body).to eq ("\[\]")
      end
    end

    context "with products" do
      before :each do
        FactoryBot.create_list(:product,10)
      end

      it "lists products" do
        get v1_products_path+".json", headers: headers
        expect(response).to have_http_status(200)
        list = JSON.parse(response.body)
        expect(list.count).to eq 10
        first_product = Product.order(:name).first
        expect(list.first).to eq ({
          "name" => first_product.name, 
          "description" => first_product.description, 
          "id" => first_product.id, 
          "price" => first_product.price.to_s})
      end
    end
  end
end

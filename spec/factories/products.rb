FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence(1) }
    price { Faker::Commerce.price }
  end
end

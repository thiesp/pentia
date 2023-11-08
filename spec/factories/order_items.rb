FactoryBot.define do
  factory :order_item do
    order { nil }
    amount { 1 }
    product { nil }
    price { "9.99" }
  end
end

FactoryBot.define do
  factory :basket_item do
    amount { 1 }
    product { nil }
    basket { nil }
  end
end

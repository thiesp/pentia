FactoryBot.define do
    factory :user do
        name { Faker::Name.name }
        email { Faker::Internet.email }
        after(:build){|user| user.password = "123456"}
    end
end

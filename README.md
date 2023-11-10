# README

* Ruby version 3.2.2

* Install gems

`gem install bundler`

`bundle`

* Database creation

`rails db:create`

* Database initialization

Creates some products to play with

`rails db:seed`

* How to run the test suite

`bundle exec rspec -fd`

```
V1::Basket
  GET /v1/basket
    without items
      returns an empty array
    with items
      lists basket items
  PUT /v1/basket/add_item
    adds an item to the basket
    does not add unknown products
    with full basket
      removes basket items without amount
  PUT /v1/basket/remove_item
    with full basket
      remove an item from the basket
    with empty basket
      remove an item from the basket
  DELETE /v1/basket
    with full basket
      empties the basket
    without basket
      answers ok

V1::Orders
  GET /v1/orders
    without orders
      returns an empty array
    with an order
      returns array with that order
      with changing price
        returns array with that order where the price remains the old price
  POST /v1/orders
    with full basket
      creates a new order
    with empty basket
      does not create a new order

V1::Products
  GET /v1/products
    without products
      returns an empty array
    with products
      lists products

V1::Registrations
  POST /v1/registrations
    create a new user
    provides a auth token
    rejects wrong email
    rejects too short passwords
    with user
      rejects existing users

V1::Sessions
  with user
    POST /v1/sessions
      create a new session
      provides a auth token
      rejects wrong credentials
      rejects wrong api key

Finished in 0.41172 seconds (files took 0.56549 seconds to load)
25 examples, 0 failures
```

* Start server

`rails s`

* API documentation

[http://localhost:3000/apipie/1.html](http://localhost:3000/apipie/1.html)

* Queries

Register a user

```
curl --location 'localhost:3000/v1/registrations.json' \
--header 'Api-Key: f85e7fe6a5443b5aebb704a705051dcc887586109436040c2a117d06f15f65dafff88d100848ca3dda067fe4c2f5ecf9eabb05878078aa08b2e49bb9be57d144' \
--header 'Content-Type: application/json' \
--data-raw '{"user":{"name":"Test User", "email": "test@test.dk", "password":"123456"}}'
```

```
{
    "name": "Test User",
    "email": "test@test.dk",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJiN2M0ZTM1MS02MTY5LTRhZjktYTdiYi1iM2QzZjU5NjQ0N2IiLCJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjk5NjA5NTgzLCJleHAiOjE2OTk2MTMxODN9.QuHkQzfxU18pn0U2qQYxj8UrfvDAEfjN_FlsKdPDBBU"
}
```

Login as a user

```
curl --location 'localhost:3000/v1/sessions.json' \
--header 'Api-Key: f85e7fe6a5443b5aebb704a705051dcc887586109436040c2a117d06f15f65dafff88d100848ca3dda067fe4c2f5ecf9eabb05878078aa08b2e49bb9be57d144' \
--header 'Content-Type: application/json' \
--data-raw '{"user":{"email": "test@test.dk", "password":"123456"}}'
```

```
{
    "name": "Test User",
    "email": "test@test.dk",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJiN2M0ZTM1MS02MTY5LTRhZjktYTdiYi1iM2QzZjU5NjQ0N2IiLCJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjk5NjA5Njc4LCJleHAiOjE2OTk2MTMyNzh9.mabywRuW5F-QoB5iyr6ly9Vr0i-0O7hzg5JTILWv3n0"
}
```

GET products

```
curl --location 'localhost:3000/v1/products.json' \
--header 'Api-Key: f85e7fe6a5443b5aebb704a705051dcc887586109436040c2a117d06f15f65dafff88d100848ca3dda067fe4c2f5ecf9eabb05878078aa08b2e49bb9be57d144' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJiN2M0ZTM1MS02MTY5LTRhZjktYTdiYi1iM2QzZjU5NjQ0N2IiLCJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjk5NjA5Njc4LCJleHAiOjE2OTk2MTMyNzh9.mabywRuW5F-QoB5iyr6ly9Vr0i-0O7hzg5JTILWv3n0'
```

```
[
    {
        "name": "Aerodynamic Bronze Bench",
        "description": "Corrupti quisquam at blanditiis.",
        "id": 16,
        "price": "7.61"
    },
    {
        "name": "Awesome Wooden Keyboard",
        "description": "Consequuntur doloremque et molestiae.",
        "id": 12,
        "price": "97.71"
    },
    {
        "name": "Fantastic Rubber Bottle",
        "description": "Quos voluptatem ad minus.",
        "id": 15,
        "price": "27.2"
    },
    {
        "name": "Gorgeous Concrete Chair",
        "description": "Voluptas maxime illo possimus.",
        "id": 20,
        "price": "18.87"
    },
    {
        "name": "Heavy Duty Silk Table",
        "description": "Cupiditate minus adipisci et.",
        "id": 13,
        "price": "94.49"
    },
    {
        "name": "Incredible Cotton Computer",
        "description": "Sapiente sit veniam qui.",
        "id": 14,
        "price": "70.81"
    },
    {
        "name": "Intelligent Marble Lamp",
        "description": "Voluptate dolorem sapiente qui.",
        "id": 11,
        "price": "57.21"
    },
    {
        "name": "Intelligent Rubber Pants",
        "description": "Libero eius eum rerum.",
        "id": 18,
        "price": "37.16"
    },
    {
        "name": "Sleek Granite Knife",
        "description": "Ducimus at earum nostrum.",
        "id": 17,
        "price": "76.54"
    },
    {
        "name": "Synergistic Linen Car",
        "description": "Et et nesciunt aut.",
        "id": 19,
        "price": "46.0"
    }
]
```

Add items to basket

```
curl --location --request PUT 'localhost:3000/v1/basket/add_item.json' \
--header 'Api-Key: f85e7fe6a5443b5aebb704a705051dcc887586109436040c2a117d06f15f65dafff88d100848ca3dda067fe4c2f5ecf9eabb05878078aa08b2e49bb9be57d144' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJiN2M0ZTM1MS02MTY5LTRhZjktYTdiYi1iM2QzZjU5NjQ0N2IiLCJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjk5NjA5Njc4LCJleHAiOjE2OTk2MTMyNzh9.mabywRuW5F-QoB5iyr6ly9Vr0i-0O7hzg5JTILWv3n0' \
--header 'Content-Type: application/json' \
--data '{"basket_item":{"product_id": 12, "amount": "5"}}'
```
Status 200

GET basket

```
curl --location 'localhost:3000/v1/basket.json' \
--header 'Api-Key: f85e7fe6a5443b5aebb704a705051dcc887586109436040c2a117d06f15f65dafff88d100848ca3dda067fe4c2f5ecf9eabb05878078aa08b2e49bb9be57d144' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJiN2M0ZTM1MS02MTY5LTRhZjktYTdiYi1iM2QzZjU5NjQ0N2IiLCJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjk5NjA5Njc4LCJleHAiOjE2OTk2MTMyNzh9.mabywRuW5F-QoB5iyr6ly9Vr0i-0O7hzg5JTILWv3n0'
```

```
[
    {
        "name": "Awesome Wooden Keyboard",
        "description": "Consequuntur doloremque et molestiae.",
        "product_id": 12,
        "price": "97.71",
        "amount": 5
    }
]
```

Remove items from basket

```
curl --location --request PUT 'localhost:3000/v1/basket/remove_item.json' \
--header 'Api-Key: f85e7fe6a5443b5aebb704a705051dcc887586109436040c2a117d06f15f65dafff88d100848ca3dda067fe4c2f5ecf9eabb05878078aa08b2e49bb9be57d144' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJiN2M0ZTM1MS02MTY5LTRhZjktYTdiYi1iM2QzZjU5NjQ0N2IiLCJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjk5NjA5Njc4LCJleHAiOjE2OTk2MTMyNzh9.mabywRuW5F-QoB5iyr6ly9Vr0i-0O7hzg5JTILWv3n0' \
--header 'Content-Type: application/json' \
--data '{"basket_item":{"product_id": 12}}'
```

Status 200

Empty basket

```
curl --location --request DELETE 'localhost:3000/v1/basket.json' \
--header 'Api-Key: f85e7fe6a5443b5aebb704a705051dcc887586109436040c2a117d06f15f65dafff88d100848ca3dda067fe4c2f5ecf9eabb05878078aa08b2e49bb9be57d144' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJiN2M0ZTM1MS02MTY5LTRhZjktYTdiYi1iM2QzZjU5NjQ0N2IiLCJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjk5NjA5Njc4LCJleHAiOjE2OTk2MTMyNzh9.mabywRuW5F-QoB5iyr6ly9Vr0i-0O7hzg5JTILWv3n0' \
--data ''
```

Status 200

Create order from basket

```
curl --location --request POST 'localhost:3000/v1/orders.json' \
--header 'Api-Key: f85e7fe6a5443b5aebb704a705051dcc887586109436040c2a117d06f15f65dafff88d100848ca3dda067fe4c2f5ecf9eabb05878078aa08b2e49bb9be57d144' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJiN2M0ZTM1MS02MTY5LTRhZjktYTdiYi1iM2QzZjU5NjQ0N2IiLCJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjk5NjA5Njc4LCJleHAiOjE2OTk2MTMyNzh9.mabywRuW5F-QoB5iyr6ly9Vr0i-0O7hzg5JTILWv3n0' \
--data ''
```

Status 200

GET orders

```
curl --location 'localhost:3000/v1/orders.json' \
--header 'Api-Key: f85e7fe6a5443b5aebb704a705051dcc887586109436040c2a117d06f15f65dafff88d100848ca3dda067fe4c2f5ecf9eabb05878078aa08b2e49bb9be57d144' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJiN2M0ZTM1MS02MTY5LTRhZjktYTdiYi1iM2QzZjU5NjQ0N2IiLCJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjk5NjA5Njc4LCJleHAiOjE2OTk2MTMyNzh9.mabywRuW5F-QoB5iyr6ly9Vr0i-0O7hzg5JTILWv3n0' \
--data ''
```

```
[
    {
        "id": 1,
        "order_items": [
            {
                "name": "Awesome Wooden Keyboard",
                "description": "Consequuntur doloremque et molestiae.",
                "price": "97.71",
                "amount": 5
            }
        ]
    }
]
```
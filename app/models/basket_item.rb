class BasketItem < ApplicationRecord
  belongs_to :product
  belongs_to :basket

  validates_presence_of :amount
end

FactoryBot.define do
  factory :order_item do
    order
    product
    price { 9.99 }
    quantity { 1 }
  end
end

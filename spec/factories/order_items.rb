FactoryBot.define do
  factory :order_item do
    order nil
    product nil
    price "9.99"
    quantity 1
  end
end

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :name, to: :product

  def sum
    price * quantity
  end
end

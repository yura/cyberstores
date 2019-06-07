class OrderItemsController < ApplicationController
  include ApplicationHelper

  def create
    @order_item = OrderItem.new(order_item_params)
    @order_item.order = current_order!
    @order_item.quantity ||= 1
    @order_item.price = @order_item.product.price

    @order_item.save

    redirect_to cart_path
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_id)
  end
end

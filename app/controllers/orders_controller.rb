class OrdersController < ApplicationController
  include ApplicationHelper

  def cart
    @order = current_order
  end
end

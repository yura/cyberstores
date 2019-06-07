# frozen_string_literal: true

# Application-wide helper methods
module ApplicationHelper
  def current_store
    Store.current_store(request)
  end

  def current_order
    store = current_store
    if session[:orders] && order_id = session[:orders][store.id.to_s]
      Order.find_by(id: order_id, store_id: store.id)
    end
  end

  def current_order!
    order = current_order
    if order.nil?
      store = current_store
      order = Order.create(store: store)
      session[:orders] ||= {}
      session[:orders][store.id.to_s] = order.id
    end
    order
  end
end

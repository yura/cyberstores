require 'rails_helper'

RSpec.describe 'Cart', type: :feature do
  describe 'add to cart' do
    let(:store) { create(:store) }
    let(:product) { create(:product, store: store) }

    subject(:add_product_to_cart) do
      # create product
      product

      visit_store store
      click_on product.name
      click_on 'Добавить в корзину'
    end

    it 'creates new order and adds order item with the product' do
      add_product_to_cart
      order = Order.last
      expect(order.order_items.map(&:product)).to include(product)
    end

    it 'assigns order item price from the product' do
      add_product_to_cart
      expect(OrderItem.last.price).to eq(product.price)
    end

    it 'renders product name in the cart' do
      add_product_to_cart
      expect(page).to have_css('table#cart td.product-name', text: product.name)
    end
  end
end

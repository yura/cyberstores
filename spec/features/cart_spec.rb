require 'rails_helper'

RSpec.describe 'Cart', type: :feature do
  let(:store) { create(:store) }
  let(:product) { create(:product, store: store) }

  describe 'add to cart' do
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

    it 'assigns order item quantity to 1' do
      add_product_to_cart
      expect(OrderItem.last.quantity).to eq(1)
    end

    it 'renders product name in the cart' do
      add_product_to_cart
      expect(page).to have_css('table#cart td.product-name', text: product.name)
    end

    it 'renders quantity in the cart' do
      add_product_to_cart
      expect(page).to have_css('table#cart td.quantity', text: 1)
    end
  end

  describe 'add to cart twice' do
    subject(:add_product_to_cart_twice) do
      # create product
      product

      visit_store store
      click_on product.name
      click_on 'Добавить в корзину'

      visit_store store
      click_on product.name
      click_on 'Добавить в корзину'
    end

    it 'creates just one order item' do
      add_product_to_cart_twice
      order = Order.last
      expect(order.order_items.size).to eq(1)
    end

    it 'changes item quantity to 2' do
      add_product_to_cart_twice
      order = Order.last
      expect(order.order_items.first.quantity).to eq(2)
    end

    it 'renders quantity in the cart' do
      add_product_to_cart_twice
      expect(page).to have_css('table#cart td.quantity', text: 2)
    end
  end
end

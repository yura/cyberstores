require 'rails_helper'

RSpec.describe 'Cart', type: :feature do
  describe 'add to cart' do
    let(:store) { create(:store) }
    let(:product) { create(:product, store: store) }

    before do
      product
      visit_store store
    end

    it 'adds product to cart' do
      click_on product.name
      click_on 'Добавить в корзину'

      order = Order.last
      expect(order.order_items.map(&:product)).to include(product)
    end
  end
end

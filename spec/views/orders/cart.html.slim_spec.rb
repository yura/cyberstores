require 'rails_helper'

RSpec.describe 'orders/cart', type: :view do
  let(:product) { create(:product) }
  let(:order) { create(:order) }
  let(:order_item) { create(:order_item, product: product, order: order) }

  before do
    order_item
    order.reload
    assign(:order, order)
  end

  it 'renders empty cart if cart is empty' do
    order.order_items.clear
    render
    expect(rendered).to have_content('Корзина пуста')
  end

  it 'renders empty cart if current order is nil' do
    assign(:order, nil)
    render
    expect(rendered).to have_content('Корзина пуста')
  end

  it 'renders product name' do
    render
    expect(rendered).to have_css('.product-name', text: product.name)
  end
end

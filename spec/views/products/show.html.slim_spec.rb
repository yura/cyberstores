require 'rails_helper'

RSpec.describe 'products/show', type: :view do
  let(:product) { create(:product) }
  before do
    assign(:product, product)
  end

  it 'renders "Add to cart" link' do
    render
    expect(rendered).to have_selector(:link_or_button, 'Добавить в корзину')
  end
end

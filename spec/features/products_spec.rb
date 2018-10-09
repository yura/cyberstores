# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products page', type: :feature do
  describe 'list of products' do
    it 'renders list of products' do
      create(:product, name: 'Cheesecake')
      visit '/'
      expect(page).to have_css('.products .product-name', text: 'Cheesecake')
    end
  end

  describe 'create new product' do
    it 'create new product' do
      visit new_product_path
      fill_in 'Name', with: 'The Haskell Book'
      fill_in 'Description', with: 'The best book on Haskell'
      fill_in 'Price', with: 55
      click_on 'Save'

      product = Product.last
      expect(product).not_to be_nil
      expect(product.name).to eq('The Haskell Book')
      expect(product.description).to eq('The best book on Haskell')
      expect(product.price).to eq(55)
    end

    it 'does not create a product with invalid data' do
      visit new_product_path
      fill_in 'Description', with: 'The best book on Haskell'
      fill_in 'Price', with: 55
      click_on 'Save'

      product = Product.last
      expect(product).to be_nil
    end
  end

  describe 'update existing product' do
    let!(:product) { create(:product) }

    it 'updates existing product' do
      visit edit_product_path(product)
      fill_in 'Name', with: 'The Haskell Book'
      fill_in 'Description', with: 'The best book on Haskell'
      fill_in 'Price', with: '55'
      click_on 'Save'

      product.reload
      expect(product.name).to eq('The Haskell Book')
      expect(product.description).to eq('The best book on Haskell')
      expect(product.price).to eq(55)
    end

    it 'does not update a product with invalid data' do
      visit edit_product_path(product)
      fill_in 'Name', with: ''
      fill_in 'Description', with: 'The best book on Haskell'
      fill_in 'Price', with: '55'
      click_on 'Save'

      product.reload
      expect(product.description).not_to eq('The best book on Haskell')
      expect(product.price).not_to eq(55)
    end
  end
end

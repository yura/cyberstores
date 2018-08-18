require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET /products' do
    let!(:cupcake) { create(:product, name: 'Cupcake') }
    let!(:cheesecake) { create(:product, name: 'Cheesecake') }

    it 'renders list of products' do
      visit '/products'
      within('.products') do
        expect(page).to have_content('Cupcake')
        expect(page).to have_content('Cheesecake')
      end
    end
  end

  describe 'create new product' do
    it 'creates new product' do
      visit new_product_path
      fill_in 'Name', with: 'The Haskell Book'
      fill_in 'Description', with: 'The best book on Haskell'
      fill_in 'Price', with: 55
      click_on 'Save'

      product = Product.last
      expect(product).to_not be_nil
      expect(product.name).to eq('The Haskell Book')
      expect(product.description).to eq('The best book on Haskell')
      expect(product.price).to eq(55)
    end

    it 'does not create a invalid product' do
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
      expect(product.description).to_not eq('The best book on Haskell')
      expect(product.price).to_not eq(55)
    end
  end

  describe 'delete product' do
    let!(:product) { create(:product) }

    it 'delete existing product', js: true do
      expect do
        delete "/products/#{product.id}"
      end.to change { Product.count }.by(-1)
    end
  end
end

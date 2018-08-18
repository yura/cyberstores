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

  describe "POST /products" do
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
  end
end

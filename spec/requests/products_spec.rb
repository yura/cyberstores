require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /products" do
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
end

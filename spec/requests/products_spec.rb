# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:store) { create(:store) }

  describe 'GET /products' do
    subject(:get_products) { get products_path }

    before do
      allow_any_instance_of(ProductsController).to receive(:current_store).and_return(store)
      create(:product, name: 'Cheesecake', store: store)
    end

    it 'renders response with 200 status' do
      get_products
      expect(response).to have_http_status(:ok)
    end

    it 'renders products from the current store' do
      get_products
      expect(response.body).to include('Cheesecake')
    end

    it 'does not render products from another store' do
      other_store = create(:store)
      create(:product, name: 'Cupcake', store: other_store)

      get_products
      expect(response.body).not_to include('Cupcake')
    end
  end

  describe 'GET /products/1' do
    subject(:show_product) { get product_path(product) }

    let(:product) { create(:product) }

    it 'renders product page' do
      show_product
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(product.name)
    end
  end

  describe 'GET /products/new' do
    it 'renders new product form' do
      get new_product_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('New Product')
    end
  end

  describe 'POST /products' do
    subject(:create_product) do
      post products_path, params: { product: { name: 'Cupcake' } }
    end

    it 'creates new product' do
      expect { create_product }.to change(Product, :count).by(1)
    end
  end

  describe 'GET /products/1/edit' do
    subject(:edit_product) { get edit_product_path(product) }

    let(:product) { create(:product, name: 'Cheesecake') }

    it 'renders edit product form' do
      edit_product
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Editing Product')
    end
  end

  describe 'PATCH /products/1' do
    subject(:update_product) do
      patch product_path(product), params: { product: { name: 'Best Book' } }
    end

    let(:product) { create(:product) }

    it 'redirects to products page'

    it 'updates existing product' do
      update_product
      product.reload
      expect(product.name).to eq('Best Book')
    end
  end

  describe 'DELETE /products/1' do
    it 'delete existing product' do
      product = create(:product)
      expect { delete product_path(product) }.to change(Product, :count).by(-1)
    end
  end
end

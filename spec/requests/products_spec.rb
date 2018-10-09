# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET /products' do
    it 'renders list of products' do
      create(:product, name: 'Cheesecake')
      get products_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Cheesecake')
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

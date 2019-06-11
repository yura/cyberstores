# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItemsController, type: :request do
  let(:store) { create(:store) }
  let(:product) { create(:product, store: store) }

  before do
    allow_any_instance_of(OrderItemsController).to receive(:current_store).and_return(store)
  end

  describe "POST /order_items" do
    def post_create_order_item
      post order_items_path, params: { order_item: { product_id: product.id } }
    end

    subject(:create_order_item) { post_create_order_item }

    it 'creates new order item' do
      expect { create_order_item }.to change(OrderItem, :count).by(1)
    end

    it 'creates new order' do
      expect { create_order_item }.to change(Order, :count).by(1)
    end

    it 'redirects to cart page' do
      create_order_item
      expect(response).to redirect_to(cart_path)
    end

    context '[order item for given product is in the cart already]' do
      before do
        post_create_order_item
      end

      it 'does not create new order item' do
        expect { create_order_item }.not_to change(OrderItem, :count)
      end

      it 'does not create new order' do
        expect { create_order_item }.not_to change(Order, :count)
      end
    end
  end
end



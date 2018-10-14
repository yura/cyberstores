require 'rails_helper'

RSpec.describe OrdersController do
  describe 'GET cart' do
    it 'renders cart' do
      get cart_path
      expect(response.body).to include('Корзина')
    end
  end
end

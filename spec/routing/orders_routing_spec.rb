# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :routing do
  describe 'routing' do
    it 'routes to #edit' do
      expect(get: '/cart').to route_to('orders#cart')
    end
  end
end


require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { is_expected.to delegate_method(:name).to(:product) }

  describe '#sum' do
    let(:order_item) { build(:order_item, quantity: 10, price: 50) }

    it 'returns production of price by quantity' do
      expect(order_item.sum).to eq(500)
    end
  end
end

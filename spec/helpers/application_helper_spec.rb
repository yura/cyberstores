require 'rails_helper'
RSpec.describe ApplicationHelper, type: :helper do
  let(:store) { create(:store, name: 'Robots', subdomain: 'robots') }

  before do
    @request.host = "#{store.subdomain}.#{@request.host}"
  end

  describe '#current_store' do
    it 'returns current store by subdomain' do
      expect(helper.current_store).to eq(store)
    end
  end

  describe "#current_order" do
    let!(:store) { create(:store) }
    let!(:order) { create(:order, store: store) }

    before do
      allow(helper).to receive(:current_store) { store }
    end

    it "returns nil if no current_order exists" do
      expect(helper.current_order).to be_nil
    end

    it "returns order by id stored in the session" do
      session[:orders] = {}
      session[:orders][store.id] = order.id
      expect(helper.current_order).to eq(order)
    end
  end

  describe '#current_order!' do
    before do
      allow(helper).to receive(:current_store).and_return(store)
    end

    it 'creates new order if :current_order is nil' do
      expect { helper.current_order! }.to change(Order, :count).by(1)
    end

    it 'sets session[:orders][store_id] value' do
      order = helper.current_order!
      expect(session[:orders][store.id]).to eq(order.id)
    end

    it 'does not create new order on second call' do
      helper.current_order!
      expect { helper.current_order! }.not_to change(Order, :count)
    end
  end
end

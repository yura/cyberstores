require 'rails_helper'
RSpec.describe ApplicationHelper, type: :helper do
  describe '#current_store' do
    let(:store) { create(:store, name: 'Robots', subdomain: 'robots') }
    it 'returns current store by subdomain' do
      @request.host = "#{store.subdomain}.#{@request.host}"
      expect(helper.current_store).to eq(store)
    end
  end
end

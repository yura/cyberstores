require 'rails_helper'

RSpec.describe 'Stores', type: :feature do
  describe 'Store front page' do
    it 'renders store name in the page header' do
      store = create(:store, name: 'Robots', subdomain: 'robots')
      visit_store store
      expect(page).to have_store_name('Robots')
    end
  end
end

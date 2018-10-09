require 'rails_helper'

RSpec.describe Store, type: :model do
  it { should have_many(:domains) }

  let(:default_store) { create(:store, :default) }

  describe '.current_store' do
    before do
      create(:store, name: 'Robots', subdomain: 'robots')
      magnolia = create(:store, name: 'Magnolia', subdomain: 'magnolia')
      create(:domain, store: magnolia, name: 'magnolia.ru')
    end

    it 'returns store by subdomain if domain is in RESERVED_DOMAINS list' do
      request = instance_double('request', domain: 'cyberstor.es', subdomain: 'robots')
      expect(Store.current_store(request).name).to eq('Robots')
    end

    it 'returns store by host name if domain is not RESERVED_DOMAINS list' do
      request = instance_double('request', domain: 'magnolia.ru', host: 'magnolia.ru')
      expect(Store.current_store(request).name).to eq('Magnolia')
    end

    it 'returns default store if there is no such subdomain' do
      default_store = create(:store, :default)
      request = instance_double('request', domain: 'cyberstor.es', subdomain: 'new-one')
      expect(Store.current_store(request)).to eq(default_store)
    end
  end

  describe '.default' do
    it 'returns default store' do
      create(:store)
      store = create(:store, :default)
      expect(Store.default).to eq(store)
    end

    it 'creates new default store if there is no one' do
      expect { Store.default }.to change(Store, :count).by(1)
    end
  end
end

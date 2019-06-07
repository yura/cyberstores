FactoryBot.define do
  factory :domain do
    store
    name { 'cars.online' }
    master { false }
  end
end

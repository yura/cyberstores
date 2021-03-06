FactoryBot.define do
  factory :store do
    name { "My Store" }
    subdomain { "mystore" }

    trait :default do
      name { DEFAULT_STORE_NAME }
      subdomain { '' }
      default { true }
    end
  end
end

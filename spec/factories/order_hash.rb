FactoryBot.define do
  factory :order_hash, class: Hash do
    name { Faker::Name.name }
    initialize_with { attributes }
  end
end
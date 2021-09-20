FactoryBot.define do
  factory :dummy, class: OpenStruct do
    id { 1 }
    name { "CDragon" }
    tags do
      [
        "tag1",
        "tag2"
      ]
    end
    address { build(:my_class_address) }
    to_create {}
  end
end

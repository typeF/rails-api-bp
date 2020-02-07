FactoryBot.define do
  factory :item do
    name { Faker::Beer.brand }
    shop_id nil
  end
end
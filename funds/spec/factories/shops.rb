FactoryBot.define do
  factory :shop do
    title { Faker::Company.name }
    location { Faker::Address.city }
  end
end
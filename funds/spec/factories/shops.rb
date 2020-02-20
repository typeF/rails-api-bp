FactoryBot.define do
  factory :shop do
    title { Faker::Company.name }
    location { Faker::Address.city }
    created_by { Faker::Number.number(10) }
  end
end
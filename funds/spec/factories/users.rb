FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email 'example@test.com'
    password 'password'
  end
end
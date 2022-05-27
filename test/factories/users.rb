FactoryBot.define do
    factory :user do
        email { Faker::Internet.email }
        password { Faker::Internet.password }
        password_confirmation { password }
        confirmed_at { Time.now }
        name { Faker::Name.name }
        id_number { Faker::Number.number(10) }
    end
end
FactoryBot.define do
    factory :member do
        framework {
            ['Java', 'C', 'C++'].sample
        }
    end
end
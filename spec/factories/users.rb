FactoryGirl.define do
    factory :user do
        username { Faker::Name.first_name }
        password { Faker::Name.first_name }
    end
end

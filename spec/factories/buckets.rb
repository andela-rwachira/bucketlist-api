FactoryGirl.define do
    factory :bucket do
        name { Faker::Lorem.word }
        user_id nil
    end
end
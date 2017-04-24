FactoryGirl.define do
    factory :item do
        name { Faker::Lorem.word }
        done { Faker::Boolean.boolean }
        bucket_id nil
    end
end

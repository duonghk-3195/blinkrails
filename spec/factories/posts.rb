FactoryBot.define do
    factory :post do
        title {Faker::Lorem.characters(number: 50)}
        content {Faker::Lorem.characters(number: 100)}
        association :user
        # user_id {1}
        created_at {Time.now}
        updated_at {Time.now}
    end
end
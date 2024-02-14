FactoryBot.define do
    factory :user do
        name {Faker::Lorem.characters(number: 10)}
        email {"example.email@gmail.com"}
        created_at {Time.now}
        updated_at {Time.now}
        password {"123456"}
        activated {true}
        activated_at {Time.now}

    end

    factory :post do
        title {Faker::Lorem.characters(number: 50)}
        content {Faker::Lorem.characters(number: 100)}
        association :user
        # user_id {1}
        created_at {Time.now}
        updated_at {Time.now}
    end
end
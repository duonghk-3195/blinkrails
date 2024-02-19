FactoryBot.define do
    factory :user do
        name {Faker::Lorem.characters(number: 10)}
        email {"example.email@gmail.com"}
        created_at {Time.now}
        updated_at {Time.now}
        password {"123456"}
        password_confirmation {"123456"}
        activated {true}
        activated_at {Time.now}
    end
end
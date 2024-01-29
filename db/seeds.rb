# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(name: "Example User",
#             email: "example@railstutorial.org",
#             password: "123456789",
#             password_confirmation: "123456789")

# Generate a bunch of additional users.
99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "123456789"
    User.create!(name: name,
        email: email,
        password: password,
        password_confirmation: password)

end
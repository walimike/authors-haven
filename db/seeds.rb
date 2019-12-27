# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'


10.times do
    User.create(
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    username: Faker::Name.middle_name
    )
end

36.times do
    Article.create(
        user_id: rand(1..10),
        title: Faker::Lorem.sentence(word_count: rand(1..3)),
        body: Faker::Lorem.paragraph_by_chars
    )
end

100.times do
    Comment.create(
        user_id: rand(1..10),
        body: Faker::Lorem.sentence(word_count: rand(3..20)),
        article_id: rand(1..36)
    )
end
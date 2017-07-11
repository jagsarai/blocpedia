# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

10.times do
  password = "password"

  User.create!(
    username: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: password,
    password_confirmation: password,
    confirmation_token: Faker::Crypto.md5,
    confirmed_at: Faker::Time.between(DateTime.now - 1, DateTime.now),
    confirmation_sent_at: DateTime.now - 1,
    created_at: DateTime.now - 1
  )
end

users = User.all

50.times do
  wiki = Wiki.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(3),
    private: false
  )
  wiki.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  wiki.update_attribute(:updated_at, rand(10.minutes .. 11.months).ago)
end

admin = User.create!(
  username: 'Jagvir Sarai',
  email: ENV['admin_username'],
  password: ENV['admin_password'],
  password_confirmation: ENV['admin_password'],
  confirmation_token: Faker::Crypto.md5,
  confirmed_at: Faker::Time.between(DateTime.now - 1, DateTime.now),
  confirmation_sent_at: DateTime.now - 1,
  created_at: DateTime.now - 1,
  role: 'admin'
)

puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{admin.username} is created as admin"

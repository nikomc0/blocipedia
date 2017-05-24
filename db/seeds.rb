require 'random_data'

5.times do
  User.create!(
    email: Faker::Internet.safe_email,
    password:               "password",
    password_confirmation:  "password"
  )
end

users = User.all

10.times do
  Wiki.create!(
    user: users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph(10)
  )
end

puts "Seed Finished"
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."

require 'random_data'

5.times do
  User.create!(
    email: RandomData.random_email,
    password: 'helloworld',
    password_confirmation: 'helloworld'
  )
end

users = User.all

10.times do
  Wiki.create!(
    user: users.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end

puts "Seed Finished"
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."

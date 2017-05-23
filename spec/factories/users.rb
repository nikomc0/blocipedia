FactoryGirl.define do
  factory :user do
    name 'Nick James'
    email 'nick@example.com'
    password 'helloworld'
    password_confirmation 'helloworld'
  end
end

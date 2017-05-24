require 'random_data'

FactoryGirl.define do
  factory :wiki do
    title Faker::Lorem.sentence
    body Faker::Lorem.paragraphs
    private false
    user 
  end
end

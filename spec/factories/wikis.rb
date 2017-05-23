require 'random_data'

FactoryGirl.define do
  factory :wiki do
    title RandomData.random_sentence
    body RandomData.random_paragraph
    private false
    user 
  end
end

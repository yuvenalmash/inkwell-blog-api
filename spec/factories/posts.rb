require 'faker'

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    slug { Faker::Internet.slug }
    user
  end
end

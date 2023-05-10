require 'faker'

FactoryBot.define do
  factory :message do
    content { Faker::Lorem.paragraph }
    association :sender, factory: :user
    association :recipient, factory: :user
  end
end
